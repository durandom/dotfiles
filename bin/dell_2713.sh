#!/usr/bin/env bash

xrandr --newmode "2560x1440_50.00_rb" 200.25 2560 2608 2640 2720 1440 1443 1448 1474 +HSync -Vsync
xrandr --addmode HDMI2 "2560x1440_50.00_rb"
xrandr --output HDMI2 --mode "2560x1440_50.00_rb" --rotate left --left-of DP1
exit

# https://gist.githubusercontent.com/wvengen/178642bbc8236c1bdb67/raw/8d320d23ab5cef3c2df2ee51c5286cfaa9001d53/extend.sh
# extend non-HiDPI external display on DP* above HiDPI internal display eDP*
# see also https://wiki.archlinux.org/index.php/HiDPI
# you may run into https://bugs.freedesktop.org/show_bug.cgi?id=39949
#                  https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/883319

#EXT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^DP1 | head -n 1`
# dell27 on HDMI2
LODPI=HDMI2
#INT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^HDMI2 | head -n 1`
# hidpi dell27 on DP1
HIDPI=DP1

ext_w=`xrandr | sed 's/^'"${LODPI}"' [^0-9]* \([0-9]\+\)x.*$/\1/p;d'`
ext_h=`xrandr | sed 's/^'"${LODPI}"' [^0-9]* [0-9]\+x\([0-9]\+\).*$/\1/p;d'`
int_w=`xrandr | sed 's/^'"${HIDPI}"' [^0-9]* \([0-9]\+\)x.*$/\1/p;d'`
off_w=`echo $(( ($int_w-$ext_w)/2 )) | sed 's/^-//'`

#echo $ext_w
#echo $ext_h
#echo $int_w
echo xrandr --output "${HIDPI}" --auto --pos ${off_w}x${ext_h} --scale 1x1  \
       --output "${LODPI}" --auto --scale 2x2 --pos 0x0
# https://wiki.archlinux.org/index.php/HiDPI#Multiple_displays
