/*
 * linux/drivers/video/backlight/pwm_bl.c
 *
 * simple PWM based backlight control, board code has to setup
 * 1) pin configuration so PWM waveforms can output
 * 2) platform_data being correctly configured
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/fb.h>
#include <linux/backlight.h>
#include <linux/err.h>
#include <linux/pwm.h>
#include <linux/pwm_backlight.h>
#include <linux/slab.h>

struct pwm_bl_data {
	struct pwm_device	*pwm;
	struct device		*dev;
	unsigned int		period;
	unsigned int		lth_brightness;
	int			(*notify)(struct device *,
					  int brightness);
	void			(*notify_after)(struct device *,
					int brightness);
	int			(*check_fb)(struct device *, struct fb_info *);
};

static int pwm_backlight_update_status(struct backlight_device *bl)
{
	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
	int brightness = bl->props.brightness;
	int max = bl->props.max_brightness;

	if (bl->props.power != FB_BLANK_UNBLANK)
		brightness = 0;

	if (bl->props.fb_blank != FB_BLANK_UNBLANK)
		brightness = 0;

	if (pb->notify)
		brightness = pb->notify(pb->dev, brightness);

	if (brightness == 0) {
		pwm_config(pb->pwm, 0, pb->period);
		pwm_disable(pb->pwm);
	} else {
		brightness = pb->lth_brightness +
			(brightness * (pb->period - pb->lth_brightness) / max);
		pwm_config(pb->pwm, brightness, pb->period);
		pwm_enable(pb->pwm);
	}

	if (pb->notify_after)
		pb->notify_after(pb->dev, brightness);

	return 0;
}

static int pwm_backlight_get_brightness(struct backlight_device *bl)
{
	return bl->props.brightness;
}

static int pwm_backlight_check_fb(struct backlight_device *bl,
		struct fb_info *info)
{
	char *id = info->fix.id;

	if (!strcmp(id, "DISP4 BG"))
		return 1;
	else
		return 0;
}

static const struct backlight_ops pwm_backlight_ops = {
	.update_status	= pwm_backlight_update_status,
	.get_brightness	= pwm_backlight_get_brightness,
	.check_fb	= pwm_backlight_check_fb,
};

struct platform_pwm_backlight_data of_data;
static int of_get_pwm_data(struct platform_device *pdev,
		struct platform_pwm_backlight_data *data)
{
	const __be32 *parp;
	struct device_node *pwm_np, *np = pdev->dev.of_node;

	if (!np)
		return -EINVAL;

	parp = of_get_property(np, "pwm-parent", NULL);
	if (parp == NULL)
		return -EINVAL;
	of_node_put(np);

	pwm_np = of_find_node_by_phandle(be32_to_cpup(parp));
	if (pwm_np)
		of_node_put(pwm_np);
	data->pwm_id = (int)pwm_np;

	of_property_read_u32(np, "max_brightness", &data->max_brightness);
	of_property_read_u32(np, "dft_brightness", &data->dft_brightness);
	of_property_read_u32(np, "pwm_period_ns", &data->pwm_period_ns);

	return 0;
}

static int pwm_backlight_probe(struct platform_device *pdev)
{
	struct backlight_properties props;
	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
	struct backlight_device *bl;
	struct pwm_bl_data *pb;
	int ret;

	if (!data) {
		data = pdev->dev.platform_data = &of_data;
		if (of_get_pwm_data(pdev, data) < 0) {
			dev_err(&pdev->dev, "failed to find platform data\n");
			return -EINVAL;
		}
	}

	if (data->init) {
		ret = data->init(&pdev->dev);
		if (ret < 0)
			return ret;
	}

	pb = kzalloc(sizeof(*pb), GFP_KERNEL);
	if (!pb) {
		dev_err(&pdev->dev, "no memory for state\n");
		ret = -ENOMEM;
		goto err_alloc;
	}

	pb->period = data->pwm_period_ns;
	pb->notify = data->notify;
	pb->notify_after = data->notify_after;
	pb->check_fb = data->check_fb;
	pb->lth_brightness = data->lth_brightness *
		(data->pwm_period_ns / data->max_brightness);
	pb->dev = &pdev->dev;

	pb->pwm = pwm_request(data->pwm_id, "backlight");
	if (IS_ERR(pb->pwm)) {
		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
		ret = PTR_ERR(pb->pwm);
		goto err_pwm;
	} else
		dev_dbg(&pdev->dev, "got pwm for backlight\n");

	memset(&props, 0, sizeof(struct backlight_properties));
	props.type = BACKLIGHT_RAW;
	props.max_brightness = data->max_brightness;
	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
				       &pwm_backlight_ops, &props);
	if (IS_ERR(bl)) {
		dev_err(&pdev->dev, "failed to register backlight\n");
		ret = PTR_ERR(bl);
		goto err_bl;
	}

	bl->props.brightness = data->dft_brightness;
	backlight_update_status(bl);

	platform_set_drvdata(pdev, bl);
	return 0;

err_bl:
	pwm_free(pb->pwm);
err_pwm:
	kfree(pb);
err_alloc:
	if (data->exit)
		data->exit(&pdev->dev);
	return ret;
}

static int pwm_backlight_remove(struct platform_device *pdev)
{
	struct platform_pwm_backlight_data *data = pdev->dev.platform_data;
	struct backlight_device *bl = platform_get_drvdata(pdev);
	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);

	backlight_device_unregister(bl);
	pwm_config(pb->pwm, 0, pb->period);
	pwm_disable(pb->pwm);
	pwm_free(pb->pwm);
	kfree(pb);
	if (data->exit)
		data->exit(&pdev->dev);
	return 0;
}

#ifdef CONFIG_PM
static int pwm_backlight_suspend(struct platform_device *pdev,
				 pm_message_t state)
{
	struct backlight_device *bl = platform_get_drvdata(pdev);
	struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);

	if (pb->notify)
		pb->notify(pb->dev, 0);
	pwm_config(pb->pwm, 0, pb->period);
	pwm_disable(pb->pwm);
	if (pb->notify_after)
		pb->notify_after(pb->dev, 0);
	return 0;
}

static int pwm_backlight_resume(struct platform_device *pdev)
{
	struct backlight_device *bl = platform_get_drvdata(pdev);

	backlight_update_status(bl);
	return 0;
}
#else
#define pwm_backlight_suspend	NULL
#define pwm_backlight_resume	NULL
#endif

static const struct of_device_id pwm_bl_dt_ids[] = {
	{ .compatible = "pwm-bl", },
	{ /* sentinel */ }
};

static struct platform_driver pwm_backlight_driver = {
	.driver		= {
		.name	= "pwm-backlight",
		.owner	= THIS_MODULE,
		.of_match_table = pwm_bl_dt_ids,
	},
	.probe		= pwm_backlight_probe,
	.remove		= pwm_backlight_remove,
	.suspend	= pwm_backlight_suspend,
	.resume		= pwm_backlight_resume,
};

static int __init pwm_backlight_init(void)
{
	return platform_driver_register(&pwm_backlight_driver);
}
module_init(pwm_backlight_init);

static void __exit pwm_backlight_exit(void)
{
	platform_driver_unregister(&pwm_backlight_driver);
}
module_exit(pwm_backlight_exit);

MODULE_DESCRIPTION("PWM based Backlight Driver");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:pwm-backlight");

