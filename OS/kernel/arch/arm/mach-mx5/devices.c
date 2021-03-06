/*
 * Copyright 2009 Amit Kucheria <amit.kucheria@canonical.com>
 * Copyright (C) 2010 Freescale Semiconductor, Inc.
 *
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */

#include <linux/platform_device.h>
#include <linux/dma-mapping.h>
#include <mach/hardware.h>
#include <mach/imx-uart.h>
#include <mach/irqs.h>

static struct resource mxc_hsi2c_resources[] = {
	{
		.start = MX51_HSI2C_DMA_BASE_ADDR,
		.end = MX51_HSI2C_DMA_BASE_ADDR + SZ_16K - 1,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = MX51_INT_HS_I2C,
		.end = MX51_INT_HS_I2C,
		.flags = IORESOURCE_IRQ,
	},
};

struct platform_device mxc_hsi2c_device = {
	.name = "imx-i2c",
	.id = 2,
	.num_resources = ARRAY_SIZE(mxc_hsi2c_resources),
	.resource = mxc_hsi2c_resources
};

static u64 usb_dma_mask = DMA_BIT_MASK(32);

static struct resource usbotg_resources[] = {
	{
		.start = MX51_USB_OTG_BASE_ADDR,
		.end = MX51_USB_OTG_BASE_ADDR + 0x1ff,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = MX51_INT_USB_OTG,
		.flags = IORESOURCE_IRQ,
	},
};

/* OTG gadget device */
struct platform_device mxc_usbdr_udc_device = {
	.name		= "fsl-usb2-udc",
	.id		= -1,
	.num_resources	= ARRAY_SIZE(usbotg_resources),
	.resource	= usbotg_resources,
	.dev		= {
		.dma_mask		= &usb_dma_mask,
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
};

struct platform_device mx53_usbdr_udc_device = {
	.name		= "fsl-usb2-udc",
	.id		= -1,
	.num_resources	= ARRAY_SIZE(usbotg_resources),
	.resource	= usbotg_resources,
	.dev		= {
		.dma_mask		= &usb_dma_mask,
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
};

struct platform_device mxc_usbdr_host_device = {
	.name = "mxc-ehci",
	.id = 0,
	.num_resources = ARRAY_SIZE(usbotg_resources),
	.resource = usbotg_resources,
	.dev = {
		.dma_mask = &usb_dma_mask,
		.coherent_dma_mask = DMA_BIT_MASK(32),
	},
};

struct platform_device mx53_usbdr_host_device = {
	.name = "fsl-ehci",
	.id = 0,
	.num_resources = ARRAY_SIZE(usbotg_resources),
	.resource = usbotg_resources,
	.dev = {
		.dma_mask = &usb_dma_mask,
		.coherent_dma_mask = DMA_BIT_MASK(32),
	},
};

static struct resource usbotg_wakeup_resources[] = {
        {
                .start = MX51_INT_USB_OTG,/* wakeup irq */
                .flags = IORESOURCE_IRQ,
        },
        {
                .start = MX51_INT_USB_OTG,/* usb core irq */
                .flags = IORESOURCE_IRQ,
        },
};

struct platform_device mx53_usbdr_wakeup_device = {
        .name = "usb_wakeup",
        .id   = 0,
        .num_resources = ARRAY_SIZE(usbotg_wakeup_resources),
        .resource = usbotg_wakeup_resources,
};

static struct resource usbotg_xcvr_resources[] = {
	{
		.start = MX51_USB_OTG_BASE_ADDR,
		.end = MX51_USB_OTG_BASE_ADDR + 0x1ff,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = MX51_INT_USB_OTG,
		.flags = IORESOURCE_IRQ,
	},
};

struct platform_device mx53_usbdr_otg_device = {
	.name = "fsl-usb2-otg",
	.id = -1,
	.dev		= {
		.dma_mask		= &usb_dma_mask,
		.coherent_dma_mask	= DMA_BIT_MASK(32),
	},
	.resource      = usbotg_xcvr_resources,
	.num_resources = ARRAY_SIZE(usbotg_xcvr_resources),
};

static struct resource usbh1_resources[] = {
	{
		.start = MX51_USB_OTG_BASE_ADDR + 0x200,
		.end = MX51_USB_OTG_BASE_ADDR + 0x200 + 0x1ff,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = MX51_INT_USB_HS1,
		.flags = IORESOURCE_IRQ,
	},
};

struct platform_device mxc_usbh1_device = {
	.name = "mxc-ehci",
	.id = 1,
	.num_resources = ARRAY_SIZE(usbh1_resources),
	.resource = usbh1_resources,
	.dev = {
		.dma_mask = &usb_dma_mask,
		.coherent_dma_mask = DMA_BIT_MASK(32),
	},
};

struct platform_device mx53_usbh1_device = {
        .name = "fsl-ehci",
        .id = 1,
        .num_resources = ARRAY_SIZE(usbh1_resources),
        .resource = usbh1_resources,
        .dev = {
                .dma_mask = &usb_dma_mask,
                .coherent_dma_mask = DMA_BIT_MASK(32),
        },
};

static struct resource usbh2_resources[] = {
	{
		.start = MX51_USB_OTG_BASE_ADDR + 0x400,
		.end = MX51_USB_OTG_BASE_ADDR + 0x400 + 0x1ff,
		.flags = IORESOURCE_MEM,
	},
	{
		.start = MX51_INT_USB_HS2,
		.flags = IORESOURCE_IRQ,
	},
};

struct platform_device mxc_usbh2_device = {
	.name = "mxc-ehci",
	.id = 2,
	.num_resources = ARRAY_SIZE(usbh2_resources),
	.resource = usbh2_resources,
	.dev = {
		.dma_mask = &usb_dma_mask,
		.coherent_dma_mask = DMA_BIT_MASK(32),
	},
};

struct platform_device mxc_pm_device = {
	.name = "mx5_pm",
	.id = 0,
};

static struct resource usbh1_wakeup_resources[] = {
        {
                .start = MX51_INT_USB_HS1, /*wakeup irq*/
                .flags = IORESOURCE_IRQ,
        },
        {
                .start = MX51_INT_USB_HS1,
                .flags = IORESOURCE_IRQ,/* usb core irq */
        },
};

struct platform_device mx53_usbh1_wakeup_device = {
        .name = "usb_wakeup",
        .id   = 1,
        .num_resources = ARRAY_SIZE(usbh1_wakeup_resources),
        .resource = usbh1_wakeup_resources,
};
