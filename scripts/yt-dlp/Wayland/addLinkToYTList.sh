#!/bin/bash

echo $(wl-paste) >> /home/bad63r/Videos/Youtube/.list.txt
notify-send --app-name="YouTube Offline" "Link added to YouTube List" --hint='string:desktop-entry:youtube'

