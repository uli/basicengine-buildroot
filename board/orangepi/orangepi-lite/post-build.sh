#!/bin/sh
BOARD_DIR="$(dirname $0)"

cp -p $BOARD_DIR/S* $TARGET_DIR/etc/init.d/
