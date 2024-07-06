#!/bin/bash

powerprofilesctl set balanced
notify-send --app-name="Power Profile" "Power Profile: Balanced" --hint='string:desktop-entry:powerprofile'
