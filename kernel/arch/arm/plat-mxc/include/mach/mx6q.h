/*
 * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
 * Copyright 2011 Linaro Ltd.
 *
 * The code contained herein is licensed under the GNU General Public
 * License. You may obtain a copy of the GNU General Public License
 * Version 2 or later at the following locations:
 *
 * http://www.opensource.org/licenses/gpl-license.html
 * http://www.gnu.org/copyleft/gpl.html
 */

#ifndef __MACH_MX6Q_H__
#define __MACH_MX6Q_H__

#include <asm/sizes.h>

#define MX6Q_IO_P2V(x)			IMX_IO_P2V(x)
#define MX6Q_IO_ADDRESS(x)		IOMEM(MX6Q_IO_P2V(x))

/*
 * The following are the blocks that need to be statically mapped.
 * For other blocks, the base address really should be retrieved from
 * device tree.
 */
#define MX6Q_SCU_BASE_ADDR		0x00a00000
#define MX6Q_SCU_SIZE			0x1000
#define MX6Q_CCM_BASE_ADDR		0x020c4000
#define MX6Q_CCM_SIZE			0x4000
#define MX6Q_ANATOP_BASE_ADDR		0x020c8000
#define MX6Q_ANATOP_SIZE		0x1000
#define MX6Q_SRC_BASE_ADDR		0x020d8000
#define MX6Q_SRC_SIZE			0x4000
#define MX6Q_IOMUXC_BASE_ADDR		0x020e0000
#define MX6Q_IOMUXC_SIZE		0x4000
#define MX6Q_MMDC0_BASE_ADDR 		0x021b0000
#define MX6Q_MMDC0_SIZE 		0x4000
#define MX6Q_UART1_BASE_ADDR           0x02020000
#define MX6Q_UART1_SIZE                        0x4000
#define MX6Q_UART2_BASE_ADDR		0x021e8000
#define MX6Q_UART4_BASE_ADDR		0x021f0000
#define MX6Q_UART_SIZE			0x4000
#define MX6Q_IOMUXC_BASE_ADDR       	0x020e0000
#define MX6Q_IOMUXC_SIZE		0x4000

/* The last 4K is for cpu hotplug to workaround wdog issue */
#define MX6Q_IRAM_BASE_ADDR		0x00900000
#define MX6Q_IRAM_SIZE			(SZ_256K - SZ_4K)

#define MX6Q_VPU_BASE_ADDR         	0x02040000
#define MX6Q_IPU1_BASE_ADDR         	0x02400000
#define MX6Q_IPU2_BASE_ADDR         	0x02800000

/*
 * AHCI SATA
 */
#define MX6Q_SATA_BASE_ADDR		0x02200000

#define MX6Q_GPU_3D_BASE_ADDR		0x00130000
#define MX6Q_USB_OTG_BASE_ADDR		0x02184000
#define MX6Q_USB_H1_BASE_ADDR		0x02184200
#define MX6Q_USB_PHY1_BASE_ADDR		0x020c9000
#define MX6Q_USB_PHY2_BASE_ADDR		0x020ca000
#define MX6Q_USB_OTGCTRL_BASE_ADDR		0x02184800

#endif	/* __MACH_MX6Q_H__ */
