setenv bootargs console=tty0 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait ro mem=128M
setenv bootcmd fatload mmc 0:1 0x4fc00000 boot.scr; fatload mmc 0:1 0x40200000 Image; fatload mmc 0:1 0x4fa00000 sun50i-h313-x96-q-lpddr3.dtb; booti 0x40200000 - 0x4fa00000

# mkimage -C none -A arm64 -T script -d boot.cmd boot.scr