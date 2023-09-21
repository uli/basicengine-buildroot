#!/bin/sh
/usr/bin/sdl_server &
# faketime
date -s @`busybox stat -c %Y /sd/*.*|sort -n|tail -n1`
