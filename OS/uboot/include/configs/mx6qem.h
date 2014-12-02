/*
 * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
 *
 * Configuration settings for the Freescale i.MX6Q EM-IMX6DQ board.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.		See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
 * MA 02111-1307 USA
 */

#ifndef __CONFIG_H
#define __CONFIG_H

#define CONFIG_MX6
#define CONFIG_MX6Q

#include "mx6_common.h"

#define CONFIG_DISPLAY_CPUINFO
#define CONFIG_DISPLAY_BOARDINFO

/*
Kernel : arch/arm/tools/mach-types
mx6q_sabreauto          MACH_MX6Q_SABREAUTO     MX6Q_SABREAUTO          3529
mx6q_sabrelite          MACH_MX6Q_SABRELITE     MX6Q_SABRELITE          3769
mx6q_sabresd            MACH_MX6Q_SABRESD       MX6Q_SABRESD            3980
mx6q_arm2               MACH_MX6Q_ARM2          MX6Q_ARM2               3837
mx6sl_arm2              MACH_MX6SL_ARM2         MX6SL_ARM2              4091
mx6q_hdmidongle         MACH_MX6Q_HDMIDONGLE    MX6Q_HDMIDONGLE         4284
mx6sl_evk               MACH_MX6SL_EVK          MX6SL_EVK               4307
hb                      MACH_HB                 HB                      4773
cuboxi                  MACH_CUBOXI             CUBOXI                  4821
mx6q_terra              MACH_MX6Q_TERRA         MX6Q_TERRA              4831
*/
#define CONFIG_MACH_TYPE	4831


#include <asm/arch/imx-regs.h>
#include <asm/imx-common/gpio.h>

#define CONFIG_CMDLINE_TAG
#define CONFIG_SETUP_MEMORY_TAGS
#define CONFIG_INITRD_TAG
#define CONFIG_REVISION_TAG

/* Size of malloc() pool */
#define CONFIG_SYS_MALLOC_LEN           (10 * 1024 * 1024)

#define CONFIG_BOARD_EARLY_INIT_F
#define CONFIG_MISC_INIT_R
#define CONFIG_MXC_GPIO

#define CONFIG_MXC_UART

// [FALINUX]
#define CONFIG_MXC_UART_BASE            UART1_BASE
#define	CONFIG_BOOTCMD_RETRY_COUNT      20
#define	CONFIG_IMX6_FALINUX

#define CONFIG_CMD_SF
#ifdef CONFIG_CMD_SF
#define CONFIG_SPI_FLASH
#define CONFIG_SPI_FLASH_SST
#define CONFIG_MXC_SPI
#define CONFIG_SF_DEFAULT_BUS           0
#define CONFIG_SF_DEFAULT_CS           (0|(IMX_GPIO_NR(3, 19)<<8))
#define CONFIG_SF_DEFAULT_SPEED         25000000
#define CONFIG_SF_DEFAULT_MODE         (SPI_MODE_0)
#endif

/* I2C Configs */
#define CONFIG_CMD_I2C
#define CONFIG_I2C_MULTI_BUS
#define CONFIG_I2C_MXC
#define CONFIG_SYS_I2C_SPEED           100000

/* MMC Configs */
#define CONFIG_FSL_ESDHC
#define CONFIG_FSL_USDHC
#define CONFIG_SYS_FSL_ESDHC_ADDR      0
//falinux remove and added
//#define CONFIG_SYS_FSL_USDHC_NUM     2
#define CONFIG_SYS_FSL_USDHC_NUM       1

#define CONFIG_MMC
#define CONFIG_CMD_MMC
#define CONFIG_GENERIC_MMC
#define CONFIG_BOUNCE_BUFFER
#define CONFIG_CMD_EXT2
#define CONFIG_CMD_FAT
#define CONFIG_DOS_PARTITION

#define CONFIG_CMD_SATA
/*
 * SATA Configs
 */
#ifdef CONFIG_CMD_SATA
#define CONFIG_DWC_AHSATA
#define CONFIG_SYS_SATA_MAX_DEVICE     1
#define CONFIG_DWC_AHSATA_PORT_ID      0
#define CONFIG_DWC_AHSATA_BASE_ADDR    SATA_ARB_BASE_ADDR
#define CONFIG_LBA48
#define CONFIG_LIBATA
#endif

#define CONFIG_CMD_PING
#define CONFIG_CMD_DHCP
#define CONFIG_CMD_MII
#define CONFIG_CMD_NET
#define CONFIG_FEC_MXC
#define CONFIG_MII
#define IMX_FEC_BASE                   ENET_BASE_ADDR
#define CONFIG_FEC_XCV_TYPE            RGMII
#define CONFIG_ETHPRIME                "FEC"
#define CONFIG_FEC_MXC_PHYADDR         0x01
#define CONFIG_PHYLIB
#define CONFIG_DISCOVER_PHY
#define CONFIG_PHY_ATHEROS
#define CONFIG_PHY_MICREL
#ifdef CONFIG_IMX6_FALINUX
#define CONFIG_PHY_ATHEROS_AR8031
#else
#define CONFIG_PHY_MICREL_KSZ9021
#endif

/* USB Configs */
#define CONFIG_CMD_USB
#define CONFIG_CMD_FAT
#define CONFIG_USB_EHCI
#define CONFIG_USB_EHCI_MX6
#define CONFIG_USB_STORAGE
#define CONFIG_USB_HOST_ETHER
#define CONFIG_USB_ETHER_ASIX
#define CONFIG_USB_ETHER_SMSC95XX
#define CONFIG_MXC_USB_PORT            1
#define CONFIG_MXC_USB_PORTSC	      (PORT_PTS_UTMI | PORT_PTS_PTW)
#define CONFIG_MXC_USB_FLAGS	       0

/* Miscellaneous commands */
#define CONFIG_CMD_BMODE

/* Framebuffer and LCD */
#define CONFIG_VIDEO
#define CONFIG_VIDEO_IPUV3
#define CONFIG_CFB_CONSOLE
#define CONFIG_VGA_AS_SINGLE_DEVICE
#define CONFIG_SYS_CONSOLE_IS_IN_ENV
#define CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE
#define CONFIG_VIDEO_BMP_RLE8
#define CONFIG_SPLASH_SCREEN
#define CONFIG_BMP_16BPP
#define CONFIG_VIDEO_LOGO
#define CONFIG_IPUV3_CLK               260000000

/* allow to overwrite serial and ethaddr */
#define CONFIG_ENV_OVERWRITE
#define CONFIG_CONS_INDEX	           1
#define CONFIG_BAUDRATE			       115200

/* Command definition */
#include <config_cmd_default.h>

#undef CONFIG_CMD_IMLS

#define CONFIG_BOOTDELAY	           3

#define CONFIG_LOADADDR			       0x12000000
#define CONFIG_SYS_TEXT_BASE	       0x17800000

#if 0
// HDD boot
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-falinux.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_sata=console=ttymxc0,115200 root=/dev/sda1 rw " \
              "rootfstype=ext4 rootdelay=3 \0" \

// MMC Recovery 
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-falinux.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_recv=console=ttymxc0,115200 root=/dev/mmcblk0p1 rw " \
              "rootfstype=ext2 rootdelay=3 \0" \

// MMC Ubuntu
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-falinux.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_mmc=console=ttymxc0,115200 root=/dev/mmcblk0p2 rw " \
              "rootfstype=ext4 rootdelay=3 \0" \

	"readkernel=ext2load mmc 0 $loadaddr /boot/uImage.imx6; " \
		"ext2load mmc 0 $fdt_addr /boot/imx6q-falinux.dtb \0" \

	"readramdisk=ext2load mmc 0 $ram_addr /boot/ramdisk-1.0-imx6-24M.gz \0" \
	
#endif
#define CONFIG_EXTRA_ENV_SETTINGS \
	"console=ttymxc0\0" \
	"fdt_high=0xffffffff\0" \
	"initrd_high=0xffffffff\0" \
	"loadaddr=0x12000000\0" \
	"boot_fdt=try\0" \
	"bootdelay=2\0" \
	"bootargs=console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootdelay=5 " \
              "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_sata=setenv bootargs console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootwait " \
              "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_ram=setenv bootargs console=ttymxc0,115200 root=/dev/ram0 rw --no-log initrd=0x1a000000,16M ramdisk=32768 " \
              "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_mmc=setenv bootargs console=ttymxc0,115200 root=/dev/mmcblk0p1 rw --no-log rootfstype=ext4 rootdelay=5 " \
              "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \                 
	"ethaddr=00:FA:14:06:03:20\0" \
	"serverip=192.168.10.132\0" \
	"ipaddr=192.168.10.248\0" \
	"netmask=255.255.0.0\0" \
	"gatewayip=192.168.10.1\0" \
	"ip_dyn=yes\0" \
    "uboot=tftpboot 0x12000000 u-boot.imx; mmc write 0x12000000 2 800\0" \
    "kernel=tftpboot 0x12000000 uImage.imx6; mmc write 0x12000000 1000 2800\0" \
    "ramdisk=tftpboot 0x1a000000 ramdisk.imx6-1.0-32M.gz; mmc write 0x1a000000 4000 8000\0" \
    "bootram=mmc dev 0; mmcinfo; mmc read 0x12000000 1000 2800; mmc read 0x1a000000 4000 8000; bootm 0x12000000\0" \
    "bootmmc=mmc dev 0; mmcinfo; mmc read 0x12000000 1000 2800; bootm 0x12000000\0" \
	"bootcmd=run bootargs_ram bootram\0" \

#define CONFIG_ARP_TIMEOUT              200UL

/* Miscellaneous configurable options */
#define CONFIG_SYS_LONGHELP
#define CONFIG_SYS_HUSH_PARSER
#define CONFIG_SYS_PROMPT	           "MX6QFALinux U-Boot > "
#define CONFIG_AUTO_COMPLETE
#define CONFIG_SYS_CBSIZE	            256

/* Print Buffer Size */
#define CONFIG_SYS_PBSIZE (CONFIG_SYS_CBSIZE + sizeof(CONFIG_SYS_PROMPT) + 16)
#define CONFIG_SYS_MAXARGS	            16
#define CONFIG_SYS_BARGSIZE CONFIG_SYS_CBSIZE

#define CONFIG_SYS_MEMTEST_START        0x10000000
#define CONFIG_SYS_MEMTEST_END	        0x10010000
#define CONFIG_SYS_MEMTEST_SCRATCH      0x10800000

#define CONFIG_SYS_LOAD_ADDR	        CONFIG_LOADADDR
#define CONFIG_SYS_HZ		            1000

#define CONFIG_CMDLINE_EDITING

/* Physical Memory Map */
#ifdef CONFIG_EM_IMX6_DDR_SIZE_2G
#define CONFIG_NR_DRAM_BANKS            1
#elif defined CONFIG_EM_IMX6_DDR_SIZE_4G
#define CONFIG_NR_DRAM_BANKS            7
#else
#define PHYS_SDRAM_SIZE			        (1u * 1024 * 1024 * 1024)
#endif

#define PHYS_SDRAM_1                    MMDC0_ARB_BASE_ADDR
#define PHYS_SDRAM_1_SIZE               (2u * 1024 * 1024 * 1024)
#define PHYS_SDRAM_2                    (PHYS_SDRAM_1 + PHYS_SDRAM_1_SIZE)
#define PHYS_SDRAM_2_SIZE               (1u * 1024 * 1024 * 1024)
#define PHYS_SDRAM_3                    (PHYS_SDRAM_2 + PHYS_SDRAM_2_SIZE)
#define PHYS_SDRAM_3_SIZE               (512u * 1024 * 1024)
#define PHYS_SDRAM_4                    (PHYS_SDRAM_3 + PHYS_SDRAM_3_SIZE)
#define PHYS_SDRAM_4_SIZE               (128* 1024 * 1024)
#define PHYS_SDRAM_5                    (PHYS_SDRAM_4 + PHYS_SDRAM_4_SIZE)
#define PHYS_SDRAM_5_SIZE               (64* 1024 * 1024)
#define PHYS_SDRAM_6                    (PHYS_SDRAM_5 + PHYS_SDRAM_5_SIZE)
#define PHYS_SDRAM_6_SIZE               (32* 1024 * 1024)
#define PHYS_SDRAM_7                    (PHYS_SDRAM_6 + PHYS_SDRAM_6_SIZE)
#define PHYS_SDRAM_7_SIZE               (16* 1024 * 1024)
#define PHYS_SDRAM_8                    (PHYS_SDRAM_7 + PHYS_SDRAM_7_SIZE)
#define PHYS_SDRAM_8_SIZE               (8* 1024 * 1024)

#define CONFIG_SYS_SDRAM_BASE	        PHYS_SDRAM_1
#define CONFIG_SYS_INIT_RAM_ADDR        IRAM_BASE_ADDR
#define CONFIG_SYS_INIT_RAM_SIZE        IRAM_SIZE

#define CONFIG_SYS_INIT_SP_OFFSET \
       (CONFIG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
#define CONFIG_SYS_INIT_SP_ADDR \
       (CONFIG_SYS_INIT_RAM_ADDR + CONFIG_SYS_INIT_SP_OFFSET)

/* FLASH and environment organization */
#define CONFIG_SYS_NO_FLASH

#define CONFIG_ENV_SIZE                 (8 * 1024)

#define CONFIG_ENV_IS_IN_MMC		     1 
/* #define CONFIG_ENV_IS_IN_SPI_FLASH */

#if defined(CONFIG_ENV_IS_IN_MMC)
//falinux remove and added
//#define CONFIG_ENV_OFFSET             (6 * 64 * 1024)
#define CONFIG_ENV_OFFSET               (512 * 1024)
#define CONFIG_SYS_MMC_ENV_DEV           0
#define	CONFIG_SYS_MMC_ENV_PART          0
#elif defined(CONFIG_ENV_IS_IN_SPI_FLASH)
#define CONFIG_ENV_OFFSET               (768 * 1024)
#define CONFIG_ENV_SECT_SIZE            (8 * 1024)
#define CONFIG_ENV_SPI_BUS              CONFIG_SF_DEFAULT_BUS
#define CONFIG_ENV_SPI_CS               CONFIG_SF_DEFAULT_CS
#define CONFIG_ENV_SPI_MODE             CONFIG_SF_DEFAULT_MODE
#define CONFIG_ENV_SPI_MAX_HZ           CONFIG_SF_DEFAULT_SPEED
#endif

#define CONFIG_OF_LIBFDT
#define CONFIG_CMD_BOOTZ

#ifndef CONFIG_SYS_DCACHE_OFF
#define CONFIG_CMD_CACHE
#endif

#endif			       /* __CONFIG_H */
