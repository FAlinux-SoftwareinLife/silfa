/*
 * Freescale On-Chip OTP driver
 *
 * Copyright (C) 2010-2011 Freescale Semiconductor, Inc. All Rights Reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 */
#include <linux/kobject.h>
#include <linux/string.h>
#include <linux/sysfs.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/fcntl.h>
#include <linux/mutex.h>
#include <linux/clk.h>
#include <linux/err.h>
#include <linux/io.h>
#include <linux/slab.h>
#include <linux/platform_device.h>
#include <linux/fsl_devices.h>
#include <linux/of.h>
#include <linux/of_device.h>

#include "fsl_otp.h"

static DEFINE_MUTEX(otp_mutex);
static struct kobject *otp_kobj;
static struct attribute **attrs;
static struct kobj_attribute *kattr;
static struct attribute_group attr_group;
static struct mxc_otp_platform_data *otp_data;
static struct clk *otp_clk;

static inline unsigned int get_reg_index(struct kobj_attribute *tmp)
{
	return tmp - kattr;
}

static int otp_wait_busy(u32 flags)
{
	int count;
	u32 c;

	for (count = 10000; count >= 0; count--) {
		c = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CTRL);
		if (!(c & (BM_OCOTP_CTRL_BUSY | BM_OCOTP_CTRL_ERROR | flags)))
			break;
		cpu_relax();
	}
	if (count < 0)
		return -ETIMEDOUT;
	return 0;
}

static ssize_t otp_show(struct kobject *kobj, struct kobj_attribute *attr,
		      char *buf)
{
	unsigned int index = get_reg_index(attr);
	u32 value = 0;

	/* sanity check */
	if (index >= otp_data->fuse_num)
		return 0;

	mutex_lock(&otp_mutex);

	if (otp_read_prepare(otp_data)) {
		mutex_unlock(&otp_mutex);
		return 0;
	}
	value = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CUSTn(index));
	otp_read_post(otp_data);

	mutex_unlock(&otp_mutex);
	return sprintf(buf, "0x%x\n", value);
}

static int otp_write_bits(int addr, u32 data, u32 magic)
{
	u32 c; /* for control register */

	/* init the control register */
	c = __raw_readl(REGS_OCOTP_BASE + HW_OCOTP_CTRL);
	c &= ~BM_OCOTP_CTRL_ADDR;
	c |= BF(addr, OCOTP_CTRL_ADDR);
	c |= BF(magic, OCOTP_CTRL_WR_UNLOCK);
	__raw_writel(c, REGS_OCOTP_BASE + HW_OCOTP_CTRL);

	/* init the data register */
	__raw_writel(data, REGS_OCOTP_BASE + HW_OCOTP_DATA);
	otp_wait_busy(0);

	mdelay(2); /* Write Postamble */
	return 0;
}

static ssize_t otp_store(struct kobject *kobj, struct kobj_attribute *attr,
		       const char *buf, size_t count)
{
	unsigned int index = get_reg_index(attr);
	int value;

	/* sanity check */
	if (index >= otp_data->fuse_num)
		return 0;

	sscanf(buf, "0x%x", &value);

	mutex_lock(&otp_mutex);
	if (otp_write_prepare(otp_data)) {
		mutex_unlock(&otp_mutex);
		return 0;
	}
	otp_write_bits(index, value, 0x3e77);
	otp_write_post(otp_data);
	mutex_unlock(&otp_mutex);
	return count;
}

static void free_otp_attr(void)
{
	kfree(attrs);
	attrs = NULL;

	kfree(kattr);
	kattr = NULL;
}

static int __init alloc_otp_attr(struct mxc_otp_platform_data *pdata)
{
	int i;

	otp_data = pdata; /* get private data */

	/* The last one is NULL, which is used to detect the end */
	attrs = kzalloc((otp_data->fuse_num + 1) * sizeof(attrs[0]),
			GFP_KERNEL);
	kattr = kzalloc(otp_data->fuse_num * sizeof(struct kobj_attribute),
			GFP_KERNEL);

	if (!attrs || !kattr)
		goto error_out;

	for (i = 0; i < otp_data->fuse_num; i++) {
		kattr[i].attr.name = pdata->fuse_name[i];
		kattr[i].attr.mode = 0600;
		kattr[i].show  = otp_show;
		kattr[i].store = otp_store;

		attrs[i] = &kattr[i].attr;
	}
	memset(&attr_group, 0, sizeof(attr_group));
	attr_group.attrs = attrs;
	return 0;

error_out:
	free_otp_attr();
	return -ENOMEM;
}

static const struct of_device_id ocotp_dt_ids[];

static int __devinit fsl_otp_probe(struct platform_device *pdev)
{
	int retval;
	struct mxc_otp_platform_data *pdata;
	const struct of_device_id *of_id =
				of_match_device(ocotp_dt_ids, &pdev->dev);

	pdata = of_id ? of_id->data : pdev->dev.platform_data;
	if (pdata == NULL)
		return -ENODEV;

	/* Enable clock */
	otp_clk = clk_get(&pdev->dev, "ocotp_clk");
	if (otp_clk)
		clk_enable(otp_clk);

	retval = alloc_otp_attr(pdata);
	if (retval)
		return retval;

	retval = map_ocotp_addr(pdev);
	if (retval)
		goto error;

	otp_kobj = kobject_create_and_add("fsl_otp", NULL);
	if (!otp_kobj) {
		retval = -ENOMEM;
		goto error;
	}

	retval = sysfs_create_group(otp_kobj, &attr_group);
	if (retval)
		goto error;

	mutex_init(&otp_mutex);
	dev_info(&pdev->dev, "initialized\n");
	return 0;
error:
	kobject_put(otp_kobj);
	otp_kobj = NULL;
	free_otp_attr();
	unmap_ocotp_addr();
	return retval;
}

static int otp_remove(struct platform_device *pdev)
{
	struct mxc_otp_platform_data *pdata;

	pdata = pdev->dev.platform_data;
	if (pdata == NULL)
		return -ENODEV;

	kobject_put(otp_kobj);
	otp_kobj = NULL;

	free_otp_attr();
	unmap_ocotp_addr();

	if (otp_clk) {
		clk_disable(otp_clk);
		clk_put(otp_clk);
	}

	return 0;
}

#define BANK(a, b, c, d, e, f, g, h)	\
{\
	("HW_OCOTP_"#a), ("HW_OCOTP_"#b), ("HW_OCOTP_"#c), ("HW_OCOTP_"#d), \
	("HW_OCOTP_"#e), ("HW_OCOTP_"#f), ("HW_OCOTP_"#g), ("HW_OCOTP_"#h) \
}

static char *imx6q_ocotp_fuse_names[16][8] = {
	BANK(LOCK, CFG0, CFG1, CFG2, CFG3, CFG4, CFG5, CFG6),
	BANK(MEM0, MEM1, MEM2, MEM3, MEM4, ANA0, ANA1, ANA2),
	BANK(OTPMK0, SOTPMK1, OTPMK2, OTPMK3, OTPMK4, OTPMK5, OTPMK6, OTPMK7),
	BANK(SRK0, SRK1, SRK2, SRK3, SRK4, SRK5, SRK6, SRK7),
	BANK(RESP0, HSJC_RESP1, MAC0, MAC1, HDCP_KSV0, HDCP_KSV1, GP1, GP2),
	BANK(DTCP_KEY0,  DTCP_KEY1,  DTCP_KEY2,  DTCP_KEY3,  DTCP_KEY4,  MISC_CONF,  FIELD_RETURN, SRK_REVOKE),
	BANK(HDCP_KEY0,  HDCP_KEY1,  HDCP_KEY2,  HDCP_KEY3,  HDCP_KEY4,  HDCP_KEY5,  HDCP_KEY6,  HDCP_KEY7),
	BANK(HDCP_KEY8,  HDCP_KEY9,  HDCP_KEY10, HDCP_KEY11, HDCP_KEY12, HDCP_KEY13, HDCP_KEY14, HDCP_KEY15),
	BANK(HDCP_KEY16, HDCP_KEY17, HDCP_KEY18, HDCP_KEY19, HDCP_KEY20, HDCP_KEY21, HDCP_KEY22, HDCP_KEY23),
	BANK(HDCP_KEY24, HDCP_KEY25, HDCP_KEY26, HDCP_KEY27, HDCP_KEY28, HDCP_KEY29, HDCP_KEY30, HDCP_KEY31),
	BANK(HDCP_KEY32, HDCP_KEY33, HDCP_KEY34, HDCP_KEY35, HDCP_KEY36, HDCP_KEY37, HDCP_KEY38, HDCP_KEY39),
	BANK(HDCP_KEY40, HDCP_KEY41, HDCP_KEY42, HDCP_KEY43, HDCP_KEY44, HDCP_KEY45, HDCP_KEY46, HDCP_KEY47),
	BANK(HDCP_KEY48, HDCP_KEY49, HDCP_KEY50, HDCP_KEY51, HDCP_KEY52, HDCP_KEY53, HDCP_KEY54, HDCP_KEY55),
	BANK(HDCP_KEY56, HDCP_KEY57, HDCP_KEY58, HDCP_KEY59, HDCP_KEY60, HDCP_KEY61, HDCP_KEY62, HDCP_KEY63),
	BANK(HDCP_KEY64, HDCP_KEY65, HDCP_KEY66, HDCP_KEY67, HDCP_KEY68, HDCP_KEY69, HDCP_KEY70, HDCP_KEY71),
	BANK(CRC0, CRC1, CRC2, CRC3, CRC4, CRC5, CRC6, CRC7),
};

enum {
	IMX6Q_OCOTP,
};

static struct mxc_otp_platform_data ocotp_data[] = {
	[IMX6Q_OCOTP] = {
		.fuse_name	= (char **)imx6q_ocotp_fuse_names,
		.fuse_num	= 16 * 8,
	}
};

static const struct of_device_id ocotp_dt_ids[] = {
	{ .compatible = "fsl,imx6q-ocotp", .data = &ocotp_data[IMX6Q_OCOTP], },
	{ /* sentinel */ }
};

static struct platform_driver ocotp_driver = {
	.probe		= fsl_otp_probe,
	.remove		= otp_remove,
	.driver		= {
		.name   = "imx-ocotp",
		.owner	= THIS_MODULE,
		.of_match_table	= ocotp_dt_ids,
	},
};

static int __init fsl_otp_init(void)
{
	return platform_driver_register(&ocotp_driver);
}

static void __exit fsl_otp_exit(void)
{
	platform_driver_unregister(&ocotp_driver);
}
module_init(fsl_otp_init);
module_exit(fsl_otp_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Huang Shijie <b32955@freescale.com>");
MODULE_DESCRIPTION("Common driver for OTP controller");
