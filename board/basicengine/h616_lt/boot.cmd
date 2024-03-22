# old boot script, doesn't work with kernel 6.6
#setenv bootargs console=tty0 console=ttyS0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait ro mem=128M
#setenv bootcmd fatload mmc 0:1 0x4fc00000 boot.scr; fatload mmc 0:1 ${kernel_addr_r} Image; fatload mmc 0:1 ${fdt_addr_r} sun50i-h313-x96-q-lpddr3.dtb; booti ${kernel_addr_r} - ${fdtcontroladdr}

#
# To prepare u-boot script, run:
# mkimage -A arm64 -T script -O linux -d h313-boot.txt h313-boot.scr
#

part uuid ${devtype} ${devnum}:2 uuid

setenv bootargs root=PARTUUID=${uuid} rw rootwait earlycon console=ttyS0,115200n8 logo.nologo vt.cur_default=1 deferred_probe_timeout=0

setenv fdtfile sun50i-h313-x96-q-lpddr3.dtb
setenv userfdtfile h313_dtb

if load ${devtype} ${devnum}:${bootpart} ${kernel_addr_r} /Image; then
  if load ${devtype} ${devnum}:${bootpart} ${fdt_addr_r} /${userfdtfile}; then
    fdt addr ${fdt_addr_r}
    fdt resize
    if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r} /initramfs-linux.img; then
      booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r}
    else
      booti ${kernel_addr_r} - ${fdt_addr_r}
    fi;
  else
    if load ${devtype} ${devnum}:${bootpart} ${fdt_addr_r} /${fdtfile}; then
      fdt addr ${fdt_addr_r}
      fdt resize
      if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r} /initramfs-linux.img; then
        booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdt_addr_r}
      else
        booti ${kernel_addr_r} - ${fdt_addr_r}
      fi;
    else
      if load ${devtype} ${devnum}:${bootpart} ${ramdisk_addr_r} /initramfs-linux.img; then
        booti ${kernel_addr_r} ${ramdisk_addr_r}:${filesize} ${fdtcontroladdr}
      else
        booti ${kernel_addr_r} - ${fdtcontroladdr}
      fi;
    fi;
  fi;
fi
