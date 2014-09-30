/*
 * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

#include <linux/io.h>
#include <linux/clk.h>
#include <linux/err.h>
#include <linux/delay.h>
#include <linux/device.h>
#include <linux/dma-mapping.h>
#include <asm/sizes.h>
#include <mach/hardware.h>
#include <mach/devices-common.h>

#define imx_ahci_imx_data_entry_single(soc, _devid)		\
	{								\
		.devid = _devid,					\
		.iobase = soc ## _SATA_BASE_ADDR,			\
		.irq = soc ## _INT_SATA,				\
	}

#ifdef CONFIG_SOC_IMX53
const struct imx_ahci_imx_data imx53_ahci_imx_data __initconst =
	imx_ahci_imx_data_entry_single(MX53, "imx53-ahci");
#endif

enum {
	HOST_CAP = 0x00,
	HOST_CAP_SSS = (1 << 27), /* Staggered Spin-up */
	HOST_PORTS_IMPL	= 0x0C,
	HOST_TIMER1MS = 0xE0, /* Timer 1-ms */

	PORT_SATA_SR = 0x128, /*  Port0 PHY Control */
	PORT_PHY_CTL = 0x178, /*  Port0 PHY Control */
	PORT_PHY_CTL_PDDQ_LOC = 0x100000,
};

static struct clk *sata_clk, *sata_ref_clk;

/* AHCI module Initialization, if return 0, initialization is successful. */
static int imx_sata_init(struct device *dev, void __iomem *addr)
{
	u32 tmpdata;
	int ret = 0, iterations = 200;
	struct clk *clk;

	sata_clk = clk_get(dev, "ahci");
	if (IS_ERR(sata_clk)) {
		dev_err(dev, "no sata clock.\n");
		return PTR_ERR(sata_clk);
	}
	ret = clk_enable(sata_clk);
	if (ret) {
		dev_err(dev, "can't enable sata clock.\n");
		goto put_sata_clk;
	}

	/* Get the AHCI SATA PHY CLK */
	sata_ref_clk = clk_get(dev, "ahci_phy");
	if (IS_ERR(sata_ref_clk)) {
		dev_err(dev, "no sata ref clock.\n");
		ret = PTR_ERR(sata_ref_clk);
		goto release_sata_clk;
	}
	ret = clk_enable(sata_ref_clk);
	if (ret) {
		dev_err(dev, "can't enable sata ref clock.\n");
		goto put_sata_ref_clk;
	}

	/* Get the AHB clock rate, and configure the TIMER1MS reg later */
	clk = clk_get(dev, "ahci_dma");
	if (IS_ERR(clk)) {
		dev_err(dev, "no dma clock.\n");
		ret = PTR_ERR(clk);
		goto release_sata_ref_clk;
	}
	tmpdata = clk_get_rate(clk) / 1000;
	clk_put(clk);

	writel(tmpdata, addr + HOST_TIMER1MS);

	tmpdata = readl(addr + HOST_CAP);
	if (!(tmpdata & HOST_CAP_SSS)) {
		tmpdata |= HOST_CAP_SSS;
		writel(tmpdata, addr + HOST_CAP);
	}

	if (!(readl(addr + HOST_PORTS_IMPL) & 0x1))
		writel((readl(addr + HOST_PORTS_IMPL) | 0x1),
			addr + HOST_PORTS_IMPL);
	/* Release resources when there is no device on the port */
	do {
		if ((readl(addr + PORT_SATA_SR) & 0xF) == 0)
			usleep_range(2000, 3000);
		else
			break;

		if (iterations == 0) {
			/*  Enter into PDDQ mode, save power */
			pr_info("No sata disk, enter into PDDQ mode.\n");
			tmpdata = readl(addr + PORT_PHY_CTL);
			writel(tmpdata | PORT_PHY_CTL_PDDQ_LOC,
					addr + PORT_PHY_CTL);
			ret = -ENODEV;
			goto release_sata_ref_clk;
		}
	} while (iterations-- > 0);

	return 0;

release_sata_ref_clk:
	clk_disable(sata_ref_clk);
put_sata_ref_clk:
	clk_put(sata_ref_clk);
release_sata_clk:
	clk_disable(sata_clk);
put_sata_clk:
	clk_put(sata_clk);

	return ret;
}

static void imx_sata_exit(struct device *dev)
{
	clk_disable(sata_ref_clk);
	clk_put(sata_ref_clk);

	clk_disable(sata_clk);
	clk_put(sata_clk);

}
struct platform_device *__init imx_add_ahci_imx(
		const struct imx_ahci_imx_data *data,
		const struct ahci_platform_data *pdata)
{
	struct resource res[] = {
		{
			.start = data->iobase,
			.end = data->iobase + SZ_4K - 1,
			.flags = IORESOURCE_MEM,
		}, {
			.start = data->irq,
			.end = data->irq,
			.flags = IORESOURCE_IRQ,
		},
	};

	return imx_add_platform_device_dmamask(data->devid, 0,
			res, ARRAY_SIZE(res),
			pdata, sizeof(*pdata),  DMA_BIT_MASK(32));
}

struct ahci_platform_data imx_sata_pdata = {
	.init = imx_sata_init,
	.exit = imx_sata_exit,
};

#ifdef CONFIG_SOC_IMX53
struct platform_device *__init imx53_add_ahci_imx(void)
{
	return imx_add_ahci_imx(&imx53_ahci_imx_data, &pdata);
}
#endif
