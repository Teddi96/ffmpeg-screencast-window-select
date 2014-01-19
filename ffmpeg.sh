#!/bin/bash

# Created to help with FFMPEG screencast
# Using xwininfo to locate window and record it
# The recording will NOT follow the window
# Just locates the window and records the position it is in


### show_help #####################
show_help () {
	echo "Usage:"
	echo "	$0 [Options] [filename]"
	}

### Get options ####################
while getopts "?hvwf:n:" opt; do
	case "$opt" in
		h|\?) show_help; exit 0;;
		n) name=$OPTARG;;	
	esac
done

## Check for required parameters 
if [ ! -n "$name" ]; then
	echo "[ ERROR ] Parameter -n is required. You must name the video output." 
	echo "[ HELP  ] Run $0 -? for help."
	exit 0
fi

### Get information about the window (placement and size) ###############
uppl=$(xwininfo -frame) 
win_size=$(echo $uppl | grep -oEe '-geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
win_xy=$(echo $uppl | grep -oEe "Corners: \+[0-9]+[0-9]\+[0-9]+[0-9]+" | grep -oEe "[0-9]+\+[0-9]+" | sed -e 's/+/,/' )


#Video recording
ffmpeg -f x11grab -video_size $win_size -i :0.0+$win_xy -framerate 25 $name.mkv



