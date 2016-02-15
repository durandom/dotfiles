#!/bin/sh

app=$1
workspace=$(wmctrl -d | grep '\*' | cut -d ' ' -f1)
win_list=$(wmctrl -lx | grep $app | grep " $workspace " | awk '{print $1}')

IDs=$(xprop -root|grep "^_NET_CLIENT_LIST_STACKING" | tr "," " ")
IDs=(${IDs##*#})

for (( idx=${#IDs[@]}-1 ; idx>=0 ; idx-- )) ; do
    for i in $win_list; do
        if [ $((i)) = $((IDs[idx])) ]; then
            wmctrl -ia $i
            exit 0
        fi
    done
done

exit 1
