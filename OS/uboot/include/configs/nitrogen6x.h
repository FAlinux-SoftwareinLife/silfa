/*
 * Copyright (C) 2010-2011 Freescale Semiconductor, Inc.
 *
 * Configuration settings for the Boundary Devices Nitrogen6X
 * and Freescale i.MX6Q Sabre Lite boards.
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


#include "mx6_common.h"
#define CONFIG_MX6
#define CONFIG_DISPLAY_CPUINFO
#define CONFIG_DISPLAY_BOARDINFO

#define CONFIG_MACH_TYPE    3769

#include <asm/arch/imx-regs.h>
#include <asm/imx-common/gpio.h>

#define CONFIG_CMDLINE_TAG
#define CONFIG_SETUP_MEMORY_TAGS
#define CONFIG_INITRD_TAG
#define CONFIG_REVISION_TAG

/* Size of malloc() pool */
#define CONFIG_SYS_MALLOC_LEN	    (10 * 1024 * 1024)

#define CONFIG_BOARD_EARLY_INIT_F
#define CONFIG_MISC_INIT_R
#define CONFIG_MXC_GPIO
#define CONFIG_CI_UDC
#define CONFIG_USBD_HS
#define CONFIG_USB_GADGET_DUALSPEED
#define CONFIG_USB_ETHER
#define CONFIG_USB_ETH_CDC
#define CONFIG_NETCONSOLE

#define CONFIG_CMD_FUSE
#ifdef CONFIG_CMD_FUSE
#define CONFIG_MXC_OCOTP
#endif

#define CONFIG_MXC_UART
// [FALINUX] we use always uart1 even sabrelite board
#ifdef CONFIG_FALINUX
#define CONFIG_MXC_UART_BASE            UART1_BASE
#define	CONFIG_BOOTCMD_RETRY_COUNT	20
#else
#define CONFIG_MXC_UART_BASE	        UART2_BASE
#endif

#define CONFIG_CMD_SF
#ifdef CONFIG_CMD_SF
#define CONFIG_SPI_FLASH
#define CONFIG_SPI_FLASH_SST
#define CONFIG_MXC_SPI
#define CONFIG_SF_DEFAULT_BUS  0
#define CONFIG_SF_DEFAULT_CS   (0|(IMX_GPIO_NR(3, 19)<<8))
#define CONFIG_SF_DEFAULT_SPEED 25000000
#define CONFIG_SF_DEFAULT_MODE (SPI_MODE_0)
#endif

/* I2C Configs */
#define CONFIG_CMD_I2C
#define CONFIG_SYS_I2C
#define CONFIG_SYS_I2C_MXC
#define CONFIG_SYS_I2C_SPEED	    100000

/* MMC Configs */
#define CONFIG_FSL_ESDHC
#define CONFIG_FSL_USDHC
#define CONFIG_SYS_FSL_ESDHC_ADDR      0

// [FALINUX] 
#ifdef CONFIG_FALINUX
#define CONFIG_SYS_FSL_USDHC_NUM       1
#else
#define CONFIG_SYS_FSL_USDHC_NUM       2
#endif

#define CONFIG_MMC
#define CONFIG_CMD_MMC
#define CONFIG_GENERIC_MMC
#define CONFIG_BOUNCE_BUFFER
#define CONFIG_CMD_EXT2
#define CONFIG_CMD_FAT
#define CONFIG_DOS_PARTITION

#ifdef CONFIG_MX6Q
#define CONFIG_CMD_SATA
#endif

/*
 * SATA Configs
 */
#ifdef CONFIG_CMD_SATA
#define CONFIG_DWC_AHSATA
#define CONFIG_SYS_SATA_MAX_DEVICE  1
#define CONFIG_DWC_AHSATA_PORT_ID   0
#define CONFIG_DWC_AHSATA_BASE_ADDR SATA_ARB_BASE_ADDR
#define CONFIG_LBA48
#define CONFIG_LIBATA
#endif

#define CONFIG_CMD_PING
#define CONFIG_CMD_DHCP
#define CONFIG_CMD_MII
#define CONFIG_CMD_NET
#define CONFIG_FEC_MXC
#define CONFIG_MII
#define IMX_FEC_BASE		ENET_BASE_ADDR
#define CONFIG_FEC_XCV_TYPE	RGMII
#define CONFIG_ETHPRIME		"FEC"
#define CONFIG_PHYLIB
// [FALINUX] 
#ifdef CONFIG_FALINUX
#define CONFIG_FEC_MXC_PHYADDR	0x01
#define CONFIG_PHY_ATHEROS
#define CONFIG_PHY_ATHEROS_AR8031
#else
#define CONFIG_FEC_MXC_PHYADDR	6
#define CONFIG_PHY_MICREL
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
#define CONFIG_USB_ETHER_MCS7830
#define CONFIG_USB_ETHER_SMSC95XX
#define CONFIG_USB_MAX_CONTROLLER_COUNT 2
#define CONFIG_EHCI_HCD_INIT_AFTER_RESET    /* For OTG port */
#define CONFIG_MXC_USB_PORTSC	(PORT_PTS_UTMI | PORT_PTS_PTW)
#define CONFIG_MXC_USB_FLAGS	0

/* Miscellaneous commands */
#define CONFIG_CMD_BMODE
#define CONFIG_CMD_SETEXPR

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
#define CONFIG_IPUV3_CLK 260000000
#define CONFIG_CMD_HDMIDETECT
#define CONFIG_CONSOLE_MUX
#define CONFIG_IMX_HDMI

/* allow to overwrite serial and ethaddr */
#define CONFIG_ENV_OVERWRITE
#define CONFIG_CONS_INDEX          1
#define CONFIG_BAUDRATE		   115200

/* Command definition */
#include <config_cmd_default.h>

#undef CONFIG_CMD_IMLS

#define CONFIG_BOOTDELAY           2

#define CONFIG_PREBOOT             ""

#define CONFIG_LOADADDR		   0x12000000
#define CONFIG_SYS_TEXT_BASE	   0x17800000

#ifdef CONFIG_CMD_SATA
#define CONFIG_DRIVE_SATA "sata "
#else
#define CONFIG_DRIVE_SATA
#endif

#ifdef CONFIG_CMD_MMC
#define CONFIG_DRIVE_MMC "mmc "
#else
#define CONFIG_DRIVE_MMC
#endif

// [FALINUX] 
#if 0
// HDD boot
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-nadia-f1.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_sata=console=ttymxc0,115200 root=/dev/sda1 rw " \
              "rootfstype=ext4 rootdelay=3 \0" \

// MMC Recovery 
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-nadia-f1.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_recv=console=ttymxc0,115200 root=/dev/mmcblk0p1 rw " \
              "rootfstype=ext2 rootdelay=3 \0" \

// MMC Ubuntu
        "bootcmd=ext2load mmc 0:1 $loadaddr /boot/uImage.imx6; " \
                        "ext2load mmc 0:1 $fdt_addr /boot/imx6q-nadia-f1.dtb; " \
                        "bootm $loadaddr - $fdt_addr\0" \
        "bootargs_mmc=console=ttymxc0,115200 root=/dev/mmcblk0p2 rw " \
              "rootfstype=ext4 rootdelay=3 \0" \

    "readkernel=ext2load mmc 0 $loadaddr /boot/uImage.imx6; " \
	"ext2load mmc 0 $fdt_addr /boot/imx6q-nadia-f1.dtb \0" \

    "readramdisk=ext2load mmc 0 $ram_addr /boot/ramdisk-1.0-imx6-24M.gz \0" \
    
#endif

#define CONFIG_DRIVE_TYPES CONFIG_DRIVE_SATA CONFIG_DRIVE_MMC

#if defined(CONFIG_SABRELITE)
#define CONFIG_EXTRA_ENV_SETTINGS \
    "script=boot.scr\0" \
    "uimage=uImage\0" \
    "console=ttymxc1\0" \
    "fdt_high=0xffffffff\0" \
    "initrd_high=0xffffffff\0" \
    "fdt_file=imx6q-sabrelite.dtb\0" \
    "fdt_addr=0x18000000\0" \
    "boot_fdt=try\0" \
    "ip_dyn=yes\0" \
    "mmcdev=0\0" \
    "mmcpart=1\0" \
    "mmcroot=/dev/mmcblk0p2 rootwait rw\0" \
    "mmcargs=setenv bootargs console=${console},${baudrate} " \
	"root=${mmcroot}\0" \
    "loadbootscript=" \
	"fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
    "bootscript=echo Running bootscript from mmc ...; " \
	"source\0" \
    "loaduimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${uimage}\0" \
    "loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
    "mmcboot=echo Booting from mmc ...; " \
	"run mmcargs; " \
	"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
	    "if run loadfdt; then " \
		"bootm ${loadaddr} - ${fdt_addr}; " \
	    "else " \
		"if test ${boot_fdt} = try; then " \
		    "bootm; " \
		"else " \
		    "echo WARN: Cannot load the DT; " \
		"fi; " \
	    "fi; " \
	"else " \
	    "bootm; " \
	"fi;\0" \
    "netargs=setenv bootargs console=${console},${baudrate} " \
	"root=/dev/nfs " \
    "ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
	"netboot=echo Booting from net ...; " \
	"run netargs; " \
	"if test ${ip_dyn} = yes; then " \
	    "setenv get_cmd dhcp; " \
	"else " \
	    "setenv get_cmd tftp; " \
	"fi; " \
	"${get_cmd} ${uimage}; " \
	"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
	    "if ${get_cmd} ${fdt_addr} ${fdt_file}; then " \
		"bootm ${loadaddr} - ${fdt_addr}; " \
	    "else " \
		"if test ${boot_fdt} = try; then " \
		    "bootm; " \
		"else " \
		    "echo WARN: Cannot load the DT; " \
		"fi; " \
	    "fi; " \
	"else " \
	    "bootm; " \
	"fi;\0"

#define CONFIG_BOOTCOMMAND \
       "mmc dev ${mmcdev}; if mmc rescan; then " \
	   "if run loadbootscript; then " \
	       "run bootscript; " \
	   "else " \
	       "if run loaduimage; then " \
		   "run mmcboot; " \
	       "else run netboot; " \
	       "fi; " \
	   "fi; " \
       "else run netboot; fi"
#elif defined(CONFIG_TERRA) //EM-IMX6Q load boot image from mmc(no file system)
#define CONFIG_EXTRA_ENV_SETTINGS \
    "console=ttymxc0\0" \
    "fdt_high=0xffffffff\0" \
    "initrd_high=0xffffffff\0" \
    "loadaddr=0x12000000\0" \
    "boot_fdt=try\0" \
    "bootdelay=3\0" \
    "bootargs=console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootdelay=5 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_sata=setenv bootargs console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootwait " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_ram=setenv bootargs console=ttymxc0,115200 root=/dev/ram0 rw --no-log initrd=0x1a000000,16M ramdisk=32768 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_mmc=setenv bootargs console=ttymxc0,115200 root=/dev/mmcblk0p1 rw --no-log rootfstype=ext4 rootdelay=5 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "ethaddr=00:FA:14:06:03:00\0" \
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
    "bootcmd=run bootargs_ram bootram \0"
#elif defined(CONFIG_NADIA) //nadia -> load boot image from mmc file system
#define CONFIG_EXTRA_ENV_SETTINGS \
    "console=ttymxc0\0" \
    "fdt_high=0xffffffff\0" \
    "initrd_high=0xffffffff\0" \
    "loadaddr=0x12000000\0" \
    "ram_addr=0x1a000000\0" \
    "boot_fdt=try\0" \
    "bootdelay=3\0" \
    "bootargs=console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootdelay=5 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_sata=setenv bootargs console=ttymxc0,115200 root=/dev/sda1 rw --no-log rootfstype=ext4 rootwait " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_ram=setenv bootargs console=ttymxc0,115200 root=/dev/ram0 rw --no-log initrd=$ram_addr,16M ramdisk=32768 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "bootargs_mmc=setenv bootargs console=ttymxc0,115200 root=/dev/mmcblk0p1 rw --no-log rootfstype=ext4 rootdelay=5 " \
    "video=mxcfb0:dev=hdmi,1920x1080@60,if=RGB24 vmalloc=192M\0" \
    "ethaddr=00:FA:14:06:03:00\0" \
    "serverip=192.168.10.132\0" \
    "ipaddr=192.168.10.248\0" \
    "netmask=255.255.0.0\0" \
    "gatewayip=192.168.10.1\0" \
    "ip_dyn=yes\0" \
    "uboot=tftpboot 0x12000000 u-boot.imx; mmc write 0x12000000 2 800\0" \
    "kernel=tftpboot 0x12000000 uImage.imx6; mmc write 0x12000000 1000 2800\0" \
    "ramdisk=tftpboot  ramdisk.imx6-1.0-32M.gz; mmc write $ram_addr 4000 8000\0" \
    "bootram=mmc dev 0; mmcinfo; mmc read 0x12000000 1000 2800; mmc read $ram_addr 4000 8000; bootm 0x12000000\0" \
    "bootmmc=mmc dev 0; mmcinfo; mmc read 0x12000000 1000 2800; bootm 0x12000000\0" \
    "mmcboot=run bootargs_ram bootram \0" \
    "fdt_addr=0x18000000\0" \
    "readkernel=ext2load mmc 0 $loadaddr /boot/uImage.imx6; ext2load mmc 0 $fdt_addr /boot/imx6q-nadia-f1.dtb \0" \
    "readramdisk=ext2load mmc 0 $ram_addr /boot/ramdisk-1.0-imx6-24M.gz \0" \
    "bootcmd=mmc rescan; mmcinfo; ext2ls mmc 0; mmc dev 0; run readkernel; run readramdisk; bootm $loadaddr - $fdt_addr\0" 
#else
#define CONFIG_EXTRA_ENV_SETTINGS \
    "console=ttymxc1\0" \
    "clearenv=if sf probe || sf probe || sf probe 1 ; then " \
	"sf erase 0xc0000 0x2000 && " \
	"echo restored environment to factory default ; fi\0" \
    "bootcmd=for dtype in " CONFIG_DRIVE_TYPES \
	"; do " \
	    "for disk in 0 1 ; do ${dtype} dev ${disk} ;" \
		"for fs in fat ext2 ; do " \
		    "${fs}load " \
			"${dtype} ${disk}:1 " \
			"10008000 " \
			"/6x_bootscript" \
			"&& source 10008000 ; " \
		"done ; " \
	    "done ; " \
	"done; " \
	"setenv stdout serial,vga ; " \
	"echo ; echo 6x_bootscript not found ; " \
	"echo ; echo serial console at 115200, 8N1 ; echo ; " \
	"echo details at http://boundarydevices.com/6q_bootscript ; " \
	"setenv stdout serial\0" \
    "upgradeu=for dtype in " CONFIG_DRIVE_TYPES \
	"; do " \
	"for disk in 0 1 ; do ${dtype} dev ${disk} ;" \
	     "for fs in fat ext2 ; do " \
		"${fs}load ${dtype} ${disk}:1 10008000 " \
		    "/6x_upgrade " \
		    "&& source 10008000 ; " \
	    "done ; " \
	"done ; " \
    "done\0" \

#endif
/* Miscellaneous configurable options */
#define CONFIG_SYS_LONGHELP
#define CONFIG_SYS_HUSH_PARSER
// [FALINUX]
#ifdef CONFIG_FALINUX
#define CONFIG_SYS_PROMPT               "i.MX6FALinux U-Boot > "
#else
#define CONFIG_SYS_PROMPT               "U-Boot > "
#endif
#define CONFIG_AUTO_COMPLETE
#define CONFIG_SYS_CBSIZE               1024

/* Print Buffer Size */
#define CONFIG_SYS_PBSIZE (CONFIG_SYS_CBSIZE + sizeof(CONFIG_SYS_PROMPT) + 16)
#define CONFIG_SYS_MAXARGS              16
#define CONFIG_SYS_BARGSIZE CONFIG_SYS_CBSIZE

#define CONFIG_SYS_MEMTEST_START        0x10000000
#define CONFIG_SYS_MEMTEST_END	        0x10010000
#define CONFIG_SYS_MEMTEST_SCRATCH      0x10800000

#define CONFIG_SYS_LOAD_ADDR	        CONFIG_LOADADDR
// [FALINUX]
#ifdef CONFIG_FALINUX
#define CONFIG_SYS_HZ	           1000
#endif

#define CONFIG_CMDLINE_EDITING

/* Physical Memory Map */
#define PHYS_SDRAM	    MMDC0_ARB_BASE_ADDR
#define PHYS_SDRAM_SIZE     (1u * 1024 * 1024 * 1024)

// [FALINUX]
#ifdef CONFIG_FALINUX
#define PHYS_SDRAM_1        PHYS_SDRAM
#define PHYS_SDRAM_1_SIZE   (2u * 1024 * 1024 * 1024)
#define PHYS_SDRAM_2        (PHYS_SDRAM_1 + PHYS_SDRAM_1_SIZE)
#define PHYS_SDRAM_2_SIZE   (1u * 1024 * 1024 * 1024)
#define PHYS_SDRAM_3        (PHYS_SDRAM_2 + PHYS_SDRAM_2_SIZE)
#define PHYS_SDRAM_3_SIZE   (512u * 1024 * 1024)
#define PHYS_SDRAM_4        (PHYS_SDRAM_3 + PHYS_SDRAM_3_SIZE)
#define PHYS_SDRAM_4_SIZE   (128* 1024 * 1024)
#define PHYS_SDRAM_5        (PHYS_SDRAM_4 + PHYS_SDRAM_4_SIZE)
#define PHYS_SDRAM_5_SIZE   (64* 1024 * 1024)
#define PHYS_SDRAM_6        (PHYS_SDRAM_5 + PHYS_SDRAM_5_SIZE)
#define PHYS_SDRAM_6_SIZE   (32* 1024 * 1024)
#define PHYS_SDRAM_7        (PHYS_SDRAM_6 + PHYS_SDRAM_6_SIZE)
#define PHYS_SDRAM_7_SIZE   (16* 1024 * 1024)
#define PHYS_SDRAM_8        (PHYS_SDRAM_7 + PHYS_SDRAM_7_SIZE)
#define PHYS_SDRAM_8_SIZE   (8* 1024 * 1024)
#endif

// [FALINUX]
#ifdef CONFIG_TERRA             // DDR SIZE : 2G
#define CONFIG_NR_DRAM_BANKS            1
#elif defined CONFIG_NADIA      // DDR SIZE : 4G 
#define CONFIG_NR_DRAM_BANKS            7
#else
#define CONFIG_NR_DRAM_BANKS	        1
#endif

#define CONFIG_SYS_SDRAM_BASE	        PHYS_SDRAM
#define CONFIG_SYS_INIT_RAM_ADDR        IRAM_BASE_ADDR
#define CONFIG_SYS_INIT_RAM_SIZE        IRAM_SIZE

#define CONFIG_SYS_INIT_SP_OFFSET \
    (CONFIG_SYS_INIT_RAM_SIZE - GENERATED_GBL_DATA_SIZE)
#define CONFIG_SYS_INIT_SP_ADDR \
    (CONFIG_SYS_INIT_RAM_ADDR + CONFIG_SYS_INIT_SP_OFFSET)

/* FLASH and environment organization */
#define CONFIG_SYS_NO_FLASH

#define CONFIG_ENV_SIZE		(8 * 1024)

#if defined(CONFIG_SABRELITE) || defined(CONFIG_FALINUX)
#define CONFIG_ENV_IS_IN_MMC
#else
#define CONFIG_ENV_IS_IN_SPI_FLASH
#endif

#if defined(CONFIG_ENV_IS_IN_MMC)
// [FALINUX]
#ifdef CONFIG_FALINUX
#define CONFIG_ENV_OFFSET	    (512 * 64 * 1024)
#else
#define CONFIG_ENV_OFFSET	    (6   * 64 * 1024)
#endif
#define CONFIG_SYS_MMC_ENV_DEV	    0
#elif defined(CONFIG_ENV_IS_IN_SPI_FLASH)
#define CONFIG_ENV_OFFSET	    (768 * 1024)
#define CONFIG_ENV_SECT_SIZE	    (8 * 1024)
#define CONFIG_ENV_SPI_BUS	    CONFIG_SF_DEFAULT_BUS
#define CONFIG_ENV_SPI_CS	    CONFIG_SF_DEFAULT_CS
#define CONFIG_ENV_SPI_MODE	    CONFIG_SF_DEFAULT_MODE
#define CONFIG_ENV_SPI_MAX_HZ	    CONFIG_SF_DEFAULT_SPEED
#endif

#define CONFIG_OF_LIBFDT
#define CONFIG_CMD_BOOTZ

#ifndef CONFIG_SYS_DCACHE_OFF
#define CONFIG_CMD_CACHE
#endif

#define CONFIG_CMD_BMP

#define CONFIG_CMD_TIME
#define CONFIG_SYS_ALT_MEMTEST

#define CONFIG_CMD_BOOTZ
#define CONFIG_SUPPORT_RAW_INITRD
#define CONFIG_CMD_FS_GENERIC

/*
 * PCI express
 */
#ifdef CONFIG_CMD_PCI
#define CONFIG_PCI
#define CONFIG_PCI_PNP
#define CONFIG_PCI_SCAN_SHOW
#define CONFIG_PCIE_IMX
#endif

#endif	       /* __CONFIG_H */

