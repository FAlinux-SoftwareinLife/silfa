/*
 * Copyright 2011 Freescale Semiconductor, Inc.
 * Copyright 2011 Linaro Ltd.
 *
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */

#include <linux/init.h>
#include <linux/io.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/smp.h>
#include <asm/unified.h>

#define SRC_SCR				0x000
#define SRC_SIMR			0x018
#define SRC_GPR1			0x020
#define BP_SRC_SCR_WARM_RESET_ENABLE	0
#define BP_SRC_SCR_CORE1_RST		14
#define BP_SRC_SCR_CORE1_ENABLE		22
#define BP_SRC_SCR_VPU_RST		2
#define BP_SRC_SCR_IPU1_RST		3
#define BP_SRC_SCR_IPU2_RST		12
#define BP_SRC_SIMR_VPU_MASK		1
#define BP_SRC_SIMR_IPU1_MASK		2
#define BP_SRC_SIMR_IPU2_MASK		4

static void __iomem *src_base;

#ifndef CONFIG_SMP
#define cpu_logical_map(cpu)		0
#endif

void imx_reset_vpu(void)
{
	u32 val;

	/* mask interrupt due to vpu passed reset */
	val = readl_relaxed(src_base + SRC_SIMR);
	val |= (1 << BP_SRC_SIMR_VPU_MASK);
	writel_relaxed(val, src_base + SRC_SIMR);

	val = readl_relaxed(src_base + SRC_SCR);
	val |= (1 << BP_SRC_SCR_VPU_RST);    /* reset vpu */
	writel_relaxed(val, src_base + SRC_SCR);
	while (readl_relaxed(src_base + SRC_SCR) &
		(1 << BP_SRC_SCR_VPU_RST))
		;
}

void imx_reset_ipu(int ipu)
{
	u32 val;
	u32 scr_off = ipu ? BP_SRC_SCR_IPU2_RST : BP_SRC_SCR_IPU1_RST;
	u32 simr_off = ipu ? BP_SRC_SIMR_IPU2_MASK : BP_SRC_SIMR_IPU1_MASK;

	/* mask interrupt due to ipu passed reset */
	val = readl_relaxed(src_base + SRC_SIMR);
	val |= (1 << simr_off);
	writel_relaxed(val, src_base + SRC_SIMR);

	/* reset the IPU */
	val = readl_relaxed(src_base + SRC_SCR);
	val |= (1 << scr_off);
	writel_relaxed(val, src_base + SRC_SCR);

	while (readl_relaxed(src_base + SRC_SCR) &
		(1 << scr_off))
		;
}

void imx_enable_cpu(int cpu, bool enable)
{
	u32 mask, val;

	cpu = cpu_logical_map(cpu);
	mask = 1 << (BP_SRC_SCR_CORE1_ENABLE + cpu - 1);
	val = readl_relaxed(src_base + SRC_SCR);
	val = enable ? val | mask : val & ~mask;
	writel_relaxed(val, src_base + SRC_SCR);
}

void imx_set_cpu_jump(int cpu, void *jump_addr)
{
	cpu = cpu_logical_map(cpu);
	writel_relaxed(BSYM(virt_to_phys(jump_addr)),
		       src_base + SRC_GPR1 + cpu * 8);
}

void imx_src_prepare_restart(void)
{
	u32 val;

	/* clear enable bits of secondary cores */
	val = readl_relaxed(src_base + SRC_SCR);
	val &= ~(0x7 << BP_SRC_SCR_CORE1_ENABLE);
	writel_relaxed(val, src_base + SRC_SCR);

	/* clear persistent entry register of primary core */
	writel_relaxed(0, src_base + SRC_GPR1);
}

void __init imx_src_init(void)
{
	struct device_node *np;
	u32 val;

	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-src");
	src_base = of_iomap(np, 0);
	WARN_ON(!src_base);

	/*
	 * force warm reset sources to generate cold reset
	 * for a more reliable restart
	 */
	val = readl_relaxed(src_base + SRC_SCR);
	val &= ~(1 << BP_SRC_SCR_WARM_RESET_ENABLE);
	writel_relaxed(val, src_base + SRC_SCR);
}
