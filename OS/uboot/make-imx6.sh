#!/bin/sh

image_filename="u-boot.imx"

if [ ! -f include/autoconf.mk ]; then 
    make arm=ARM CROSS_COMPILE=arm-linux-gnueabihf- falinux6q2g_config
#	make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- mx6qem4g_config
fi

if [ "$1" = "" ]; then
    ARCH=arm make arm=ARM CROSS_COMPILE=arm-linux-gnueabihf- 
else
    ARCH=arm make arm=ARM CROSS_COMPILE=arm-linux-gnueabihf- $1 $2 $3
fi

if [ -f $image_filename ]; then
    echo "copy from $image_filename to /tftpboot/$target_filename"
#   cp  $image_filename /tftpboot/$target_filename
#   chmod 777 /tftpboot/$target_filename
fi
