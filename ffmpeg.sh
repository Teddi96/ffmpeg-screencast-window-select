#!/bin/bash

# Made by Loki123
# For that idiot who can't use FFMPEG

uppl=$(xwininfo -frame) 
win_size=$(echo $uppl | grep -oEe '-geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
win_xy=$(echo $uppl | grep -oEe "Corners: \+[0-9]+[0-9]\+[0-9]+[0-9]+" | grep -oEe "[0-9]+\+[0-9]+" | sed -e 's/+/,/' )
#echo $win_xy


ffmpeg -f x11grab -video_size $win_size -i :0.0+$win_xy -framerate 25 $1.mkv



