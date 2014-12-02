

uboot 사용법

1. git clone git://git.denx.de/u-boot.git


2. cd u-boot-imx6-denx/


3. patch -p1 < ../patch-ezboard/00xx-abcdefg.patch
   patch -p1 < ../patch-ezboard/00xx-abcdefg.patch
   ...
   ...
   patch -p1 < ../patch-ezboard/00xx-abcdefg.patch


4. 설정 방벙

	4.1 distclean
		make distclean
		or
		make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- distclean

	4.2  sabrelite 보드의 경우
		make mx6qsabrelite_config
		or
		make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- mx6qsabrelite_config

	4.3  em-imx6dq 보드의 경우
		make mx6qem2g_config
		or
		make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- mx6qem2g_config

	4.4  em-imx6dq 보드의 경우 4G 지원 모델
		make mx6qem4g_config
		or
		make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- mx6qem4g_config

	4.5  nadia c-server 보드의 경우 4G 지원 모델
		make mx6qem4g_nadia_config
		make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- mx6qem4g__nadia_config

5. 컴파일 방법
	make u-boot.imx
	or
	make arm=ARM CROSS_COMPILE=arm-fsl-linux-gnueabi- u-boot.imx

6. fusing 방법

   dd if=u-boot.imx of=/dev/sdx bs=512 seek=2 && sync
   or
   dd if=u-boot.imx of=/dev/mmcblk0 bs=512 seek=2 && sync




board/freescale/mx6qsabrelite/README 참조...

