#!/bin/sh
current=$(pacmd dump-volumes | awk 'NR==1{print $8}' | sed 's/\%//')
[ $current -lt 100 ] && pactl set-sink-volume 0 +5%
