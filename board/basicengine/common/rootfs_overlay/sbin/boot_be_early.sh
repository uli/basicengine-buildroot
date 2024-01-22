#!/bin/sh
JH_PLATFORM=orangepi0
test -e /sbin/boot_be_platform.sh && . /sbin/boot_be_platform.sh

# load Jailhouse Engine BASIC cell
modprobe jailhouse
/usr/sbin/jailhouse enable /etc/jailhouse/${JH_PLATFORM}.cell
/usr/sbin/jailhouse cell create /etc/jailhouse/${JH_PLATFORM}-inmate-basic.cell
/usr/sbin/jailhouse cell load ${JH_PLATFORM}-inmate-basic /usr/libexec/jailhouse/demos/beload.bin /lib/firmware/basic.bin -a 0x49000000

# load essential Linux-side services
/usr/bin/init_comms
/usr/bin/libc_server &
/usr/bin/video_recorder &

# start Engine BASIC
/usr/sbin/jailhouse cell start ${JH_PLATFORM}-inmate-basic
