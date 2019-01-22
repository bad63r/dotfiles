#!/bin/bash

processID=$(pgrep nm-applet)

kill $processID
sleep 1s
nm-applet &
echo Wi-fi is fixed ... 
echo


