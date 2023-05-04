#!/bin/sh
current=$(pacmd dump-volumes | awk 'NR==4{print $8}' | sed 's/\%//')
[ $current -lt 100 ] && pactl set-sink-volume 4 +5%
