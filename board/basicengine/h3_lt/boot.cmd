setenv fdt_high ffffffff

setenv bootargs console=ttyS0,115200 earlyprintk root=/dev/mmcblk0p2 rootwait ro quiet

fatload mmc 0 $kernel_addr_r zImage

if fatload mmc 0 $fdt_addr_r $menu_dtb ; then
	true
else
	usb start
	setenv bootmenu_0 Orange Pi Lite=setenv menu_dtb sun8i-h3-orangepi-lite.dtb
	setenv bootmenu_1 Orange Pi One=setenv menu_dtb sun8i-h3-orangepi-one.dtb
	setenv bootmenu_2 Orange Pi PC=setenv menu_dtb sun8i-h3-orangepi-pc.dtb
	setenv bootmenu_3 Orange Pi 2=setenv menu_dtb sun8i-h3-orangepi-2.dtb
	setenv bootmenu_4 Orange Pi PC Plus=setenv menu_dtb sun8i-h3-orangepi-pc-plus.dtb
	setenv bootmenu_5 Orange Pi PC Plus 2E=setenv menu_dtb sun8i-h3-orangepi-plus2e.dtb
	setenv bootmenu_6 Orange Pi Plus=setenv menu_dtb sun8i-h3-orangepi-plus.dtb
	setenv bootmenu_7 Orange Pi Zero Plus 2=setenv menu_dtb sun8i-h3-orangepi-zero-plus2.dtb
	setenv bootmenu_8 Banana Pi M2 Plus=setenv menu_dtb sun8i-h3-bananapi-m2-plus.dtb
	setenv bootmenu_9 Banana Pi M2 Plus v1.2=setenv menu_dtb sun8i-h3-bananapi-m2-plus-v1.2.dtb
	setenv bootmenu_10 Beelink X2=setenv menu_dtb sun8i-h3-beelink-x2.dtb
	setenv bootmenu_11 Emlid Neutis N5H3 Devboard=setenv menu_dtb sun8i-h3-emlid-neutis-n5h3-devboard.dtb
	setenv bootmenu_12 Libretech All H3=setenv menu_dtb sun8i-h3-libretech-all-h3-cc.dtb
	setenv bootmenu_13 Mapleboard MP130=setenv menu_dtb sun8i-h3-mapleboard-mp130.dtb
	setenv bootmenu_14 NanoPi Duo 2=setenv menu_dtb sun8i-h3-nanopi-duo2.dtb
	setenv bootmenu_15 NanoPi M1=setenv menu_dtb sun8i-h3-nanopi-m1.dtb
	setenv bootmenu_16 NanoPi M1 Plus=setenv menu_dtb sun8i-h3-nanopi-m1-plus.dtb
	setenv bootmenu_17 NanoPi Neo Air=setenv menu_dtb sun8i-h3-nanopi-neo-air.dtb
	setenv bootmenu_18 NanoPi Neo=setenv menu_dtb sun8i-h3-nanopi-neo.dtb
	setenv bootmenu_19 NanoPi R1=setenv menu_dtb sun8i-h3-nanopi-r1.dtb
	setenv bootmenu_20 Revision DVK=setenv menu_dtb sun8i-h3-rervision-dvk.dtb
	setenv bootmenu_21 ZeroPi=setenv menu_dtb sun8i-h3-zeropi.dtb
	setenv bootmenu_22 Orange Pi R1=setenv menu_dtb sun8i-h2-plus-orangepi-r1.dtb
	setenv bootmenu_23 Orange Pi Zero=setenv menu_dtb sun8i-h2-plus-orangepi-zero.dtb
	bootmenu 99
	saveenv
	fatload mmc 0 $fdt_addr_r $menu_dtb
fi  

bootz $kernel_addr_r - $fdt_addr_r
