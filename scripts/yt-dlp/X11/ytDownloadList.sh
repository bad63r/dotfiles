#!/bin/bash

declare -i counter=1
declare -i start_point=1
declare -i num_of_lines
declare -i files_to_download
declare -i downloaded = 1

commands () {
    # position script to location where list.txt & my-archive.txt files are
    cd /home/bad63r/Videos/Youtube/
    # count how many lines are in list.txt
    num_of_lines=$( cat list.txt | wc -l )
    start_point=$( cat list.txt | wc -l )

    #detect the point to where links were downloaded in list.txt
    while read LINE; do
        if [ "$LINE" == "# DOWNLOADED UNTIL THIS COMMENT" ]; then
            echo "found var"
            start_point=$((start_point - counter))
            echo "Start point is: $start_point"
            break
        fi
        counter=$(( counter + 1 ))
    # this is not done as tac list.txt | (piping...) as when piped, while process is created as subprocess and variables changes won't propagate further
    # in this script
    done < <(tac list.txt)

    #count how many videos there are to download
    files_to_download=$((num_of_lines - start_point))
    # print the videos number
    echo "There is $files_to_download videos to download"
    #sends notification, --hint argument is used for kde notification system so it can group them under one "application"
    notify-send --app-name="YouTube Offline" "Starting download of $files_to_download videos" --hint='string:desktop-entry:youtube'

    #unbuffer to work install: sudo apt install expect
    #it makes colorful output to /dev/tty as application is recognizing that it is not startard temrminal and refuses to color output by its own
    # here we are piping as we have no more variables which value we need to store further in the script
    unbuffer yt-dlp -a list.txt --download-archive my-archive.txt | tee /dev/tty | while read LINE; do
        #echo $LINE
        if [[ "$LINE" == *"[download] 100%"* ]]; then
            $files_to_download=$((files_to_download - downloaded))
            ((downloaded++))
            notify-send --app-name="YouTube Offline" "Downloaded [$downloaded/$files_to_download]" --hint='string:desktop-entry:youtube'
        fi
    done
    echo "# DOWNLOADED UNTIL THIS COMMENT" >> list.txt
    notify-send --app-name="YouTube Offline" "Yt-dlp finished download" --hint='string:desktop-entry:youtube'
    $SHELL # keep the terminal open after the previous commands are executed

}

export -f commands

konsole -e "bash -c 'commands'"





