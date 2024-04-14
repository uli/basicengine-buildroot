#!/bin/bash
platform="$1"
test -z "$platform" && platform="h616"
cp -p .config /tmp/br_config.$$
cp -p board/basicengine/${platform}/boot.cmd /tmp/boot.cmd.$$

grep -v "^#" h616_images.txt|while read uboot dtb ; do
	sed -i "s,BR2_TARGET_UBOOT_BOARD_DEFCONFIG=\".*\",BR2_TARGET_UBOOT_BOARD_DEFCONFIG=\"${uboot}\"," .config
	sed -i "s,fatload mmc 0:1 0x4fa00000 .*\.dtb,fatload mmc 0:1 0x4fa00000 ${dtb}.dtb," board/basicengine/${platform}/boot.cmd
	rm -r output/build/host-uboot-tools-*
	rm -r output/build/uboot-*
	echo "=== H616 ${uboot}"
	grep BR2_TARGET_UBOOT_BOARD_DEFCONFIG .config
	cat board/basicengine/${platform}/boot.cmd
	make
	strings output/images/boot.scr
	cp -pv output/images/sdcard.img basic_${platform}_${uboot}_sd.img
done
mv /tmp/br_config.$$ .config
mv /tmp/boot.cmd.$$ board/basicengine/${platform}/boot.cmd
