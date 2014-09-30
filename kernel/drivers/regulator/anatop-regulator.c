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

#include <linux/slab.h>
#include <linux/device.h>
#include <linux/module.h>
#include <linux/err.h>
#include <linux/io.h>
#include <linux/platform_device.h>
#include <linux/regulator/driver.h>
#include <linux/regulator/anatop-regulator.h>
#include <linux/of.h>
#include <linux/regulator/of_regulator.h>

static int anatop_set_voltage(struct regulator_dev *reg, int min_uV,
				  int max_uV, unsigned *selector)
{
	struct anatop_regulator *anatop_reg = rdev_get_drvdata(reg);
	u32 val, rega, sel;
	int uv;

	uv = min_uV;
	pr_debug("%s: uv %d, min %d, max %d\n", __func__,
		 uv, anatop_reg->rdata->min_voltage,
		 anatop_reg->rdata->max_voltage);

	if (uv < anatop_reg->rdata->min_voltage
	    || uv > anatop_reg->rdata->max_voltage) {
		if (max_uV > anatop_reg->rdata->min_voltage)
			uv = anatop_reg->rdata->min_voltage;
		else
			return -EINVAL;
	}

	if (anatop_reg->rdata->control_reg) {
		sel = (uv - anatop_reg->rdata->min_voltage) / 25000;
		val = anatop_reg->rdata->min_bit_val + sel;
		rega = (ioread32(anatop_reg->rdata->ioreg) &
		       ~(anatop_reg->rdata->vol_bit_mask <<
			 anatop_reg->rdata->vol_bit_shift));
		*selector = sel;
		pr_debug("%s: calculated val %d\n", __func__, val);
		iowrite32((val << anatop_reg->rdata->vol_bit_shift) | rega,
			     anatop_reg->rdata->ioreg);
		return 0;
	} else {
		return -ENOTSUPP;
	}
}

static int anatop_get_voltage_sel(struct regulator_dev *reg)
{
	struct anatop_regulator *anatop_reg = rdev_get_drvdata(reg);
	int selector;
	struct anatop_regulator_data *rdata = anatop_reg->rdata;

	if (rdata->control_reg) {
		u32 val = (ioread32(rdata->ioreg) >>
			   rdata->vol_bit_shift) & rdata->vol_bit_mask;
		selector = val - rdata->min_bit_val;
		return selector;
	} else {
		return -ENOTSUPP;
	}
}

static int anatop_list_voltage(struct regulator_dev *dev, unsigned selector)
{
	struct anatop_regulator *anatop_reg = rdev_get_drvdata(dev);
	int uv;
	struct anatop_regulator_data *rdata = anatop_reg->rdata;

	uv = rdata->min_voltage + selector * 25000;
	pr_debug("vddio = %d, selector = %u\n", uv, selector);
	return uv;
}

static struct regulator_ops anatop_rops = {
	.set_voltage     = anatop_set_voltage,
	.get_voltage_sel = anatop_get_voltage_sel,
	.list_voltage    = anatop_list_voltage,
};

int anatop_regulator_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct device_node *np = dev->of_node;
	struct regulator_desc *rdesc;
	struct regulator_dev *rdev;
	struct anatop_regulator *sreg;
	struct regulator_init_data *initdata;
	const __be32 *rval;

	initdata = of_get_regulator_init_data(dev, dev->of_node);
	sreg = devm_kzalloc(dev, sizeof(struct anatop_regulator), GFP_KERNEL);
	rdesc = devm_kzalloc(dev, sizeof(struct regulator_desc), GFP_KERNEL);
	sreg->initdata = initdata;
	sreg->regulator = rdesc;
	if (!rdesc) {
		return -EINVAL;
	}
	memset(rdesc,0,sizeof(struct regulator_desc));
	rdesc->name = kstrdup(of_get_property(np, "regulator-name", NULL), GFP_KERNEL);
	rdesc->ops = &anatop_rops;
	rdesc->type = REGULATOR_VOLTAGE;
	rdesc->owner = THIS_MODULE;
	sreg->rdata = devm_kzalloc(dev, sizeof(struct anatop_regulator_data), GFP_KERNEL);
	sreg->rdata->name = kstrdup(rdesc->name, GFP_KERNEL);
	rval = of_get_property(np, "control-reg",NULL);
	if (rval) {
		sreg->rdata->control_reg = be32_to_cpu(*rval);
	}
	sreg->rdata->ioreg = ioremap(sreg->rdata->control_reg,4);
	rval = of_get_property(np, "vol-bit-shift",NULL);
	if (rval) {
		sreg->rdata->vol_bit_shift = be32_to_cpu(*rval);
	}
	rval = of_get_property(np, "vol-bit-mask",NULL);
	if (rval) {
		sreg->rdata->vol_bit_mask = be32_to_cpu(*rval);
	}
	rval = of_get_property(np, "min-bit-val",NULL);
	if (rval) {
		sreg->rdata->min_bit_val = be32_to_cpu(*rval);
	}
	rval = of_get_property(np, "min-voltage",NULL);
	if (rval) {
		sreg->rdata->min_voltage = be32_to_cpu(*rval);
	}
	rval = of_get_property(np, "max-voltage",NULL);
	if (rval) {
		sreg->rdata->max_voltage = be32_to_cpu(*rval);
	}

	/* register regulator */
	rdev = regulator_register(rdesc, &pdev->dev,
				  initdata, sreg, pdev->dev.of_node);
	platform_set_drvdata(pdev, rdev);

	if (IS_ERR(rdev)) {
		dev_err(&pdev->dev, "failed to register %s\n",
			rdesc->name);
		return PTR_ERR(rdev);
	}

	return 0;
}

int anatop_regulator_remove(struct platform_device *pdev)
{
	struct regulator_dev *rdev = platform_get_drvdata(pdev);
	regulator_unregister(rdev);
	return 0;
}

struct of_device_id __devinitdata of_anatop_regulator_match_tbl[] = {
        { .compatible = "fsl,anatop-regulator", },
        { /* end */ }
};


struct platform_driver anatop_regulator = {
	.driver = {
		.name	= "anatop_regulator",
		.owner  = THIS_MODULE,
		.of_match_table = of_anatop_regulator_match_tbl,
	},
	.probe	= anatop_regulator_probe,
	.remove	= anatop_regulator_remove,
};

int anatop_regulator_init(void)
{
	return platform_driver_register(&anatop_regulator);
}

void anatop_regulator_exit(void)
{
	platform_driver_unregister(&anatop_regulator);
}

postcore_initcall(anatop_regulator_init);
module_exit(anatop_regulator_exit);

MODULE_AUTHOR("Freescale Semiconductor, Inc.");
MODULE_DESCRIPTION("ANATOP Regulator driver");
MODULE_LICENSE("GPL");
