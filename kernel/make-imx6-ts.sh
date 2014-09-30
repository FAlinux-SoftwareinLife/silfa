#!/bin/sh

build_path="../build_linaro"
module_install="../../out"
image_filename="$build_path/arch/arm/boot/uImage"
target_filename="uImage.imx6"
dtb_filename="imx6q-sabrelite.dtb"
CP_DIR="$SDK_DIR/out"

if [ -f .config ]; then
	echo ".....mrproper"
	make mrproper
fi

if [ ! -d $build_path ]; then
	mkdir $build_path
	chmod 777 $build_path
fi

if [ ! -f $build_path/.config ]; then
	echo ".....imx6 defconfig"	
	ARCH=arm make O=$build_path ts-mx6_defconfig #imx_v6_v7_defconfig
fi


if [ "$1" = "" ]; then
	ARCH=arm make O=$build_path -j4 uImage LOADADDR=0x10008000
	dtc -I dts -O dtb -o $dtb_filename arch/arm/boot/dts/imx6q-sabrelite.dts
else
	ARCH=arm make O=$build_path $1 $2 $3
fi

# build kernel modules
if [ "$1" = "modules" ] ; then
	ARCH=arm INSTALL_MOD_PATH=$module_install make O=$build_path modules
	ARCH=arm INSTALL_MOD_PATH=$module_install make O=$build_path modules_install
fi

if [ -f $image_filename ]; then
   echo "copy from $image_filename to $CP_DIR"
   echo "copy from $image_filename to /tftpboot/$target_filename"
   echo "copy from $dtb_filename to /tftpboot/"
   chmod 777 $image_filename
   cp -a $image_filename /tftpboot/$target_filename
   cp -a $dtb_filename /tftpboot/
fi


