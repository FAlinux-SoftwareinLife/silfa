#!/bin/bash

./make-imx6.sh $1


cp /tftpboot/uImage.imx6 /tftpboot/uImage.imx6-3.7
cp imx6q-sabrelite.dtb /tftpboot/

#scp /tftpboot/uImage.imx6 imx6q-sabrelite.dtb boggle70@192.168.10.190:/staff/tftpboot/
