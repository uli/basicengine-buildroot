# doesn't work with kernel 6.6
setenv bootargs console=tty0 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait ro mem=128M
setenv bootcmd fatload mmc 0:1 0x4fc00000 boot.scr; fatload mmc 0:1 ${kernel_addr_r} Image; fatload mmc 0:1 ${fdt_addr_r} sun50i-h313-x96-q-lpddr3.dtb; booti ${kernel_addr_r} - ${fdtcontroladdr}
