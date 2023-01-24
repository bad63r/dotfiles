#!/bin/bash

emacsclient -n -e "(if (> (length (frame-list)) 1) 't)" | grep -q t
if [ "$?" = "1" ]; then
    emacsclient -c -n -a "" "$@"
else
    emacsclient -n -a "" "$@"
fi
