#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp -p $BINARIES_DIR/sun8i-h3-orangepi-lite.dtb $BINARIES_DIR/devicetree.dtb
cp -p $BOARD_DIR/S* $TARGET_DIR/etc/init.d/
