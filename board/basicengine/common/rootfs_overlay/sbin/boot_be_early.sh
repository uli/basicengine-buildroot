#!/bin/sh
modprobe jailhouse
/usr/sbin/jailhouse enable /etc/jailhouse/orangepi0.cell 
/usr/sbin/jailhouse cell create /etc/jailhouse/orangepi0-inmate-basic.cell 
/usr/sbin/jailhouse cell load orangepi0-inmate-basic /usr/libexec/jailhouse/demos/beload.bin /lib/firmware/basic.bin -a 0x49000000
/usr/bin/libc_server &
/usr/sbin/jailhouse cell start orangepi0-inmate-basic
