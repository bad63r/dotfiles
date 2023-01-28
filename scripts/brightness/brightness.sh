#!/bin/bash

case "$1" in
  up)
      light -A 10
      brightness=$(light)
      message="Brightness ${brightness%.*}%"
      notify-send "$message"

  ;;

  down)
      light -U 10
      brightness=$(light)
      message="Brightness ${brightness%.*}%"
      notify-send "$message"
  ;;
esac
