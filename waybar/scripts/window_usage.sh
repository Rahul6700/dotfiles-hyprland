#!/bin/bash

pid=$(hyprctl activewindow -j | jq '.pid')

if [ -z "$pid" ]; then
    echo ''
    exit
fi

# Get CPU and RAM usage from ps
read cpu mem <<< $(ps -p "$pid" -o %cpu=,rss=)

# Convert memory from KB to MB
mem_mb=$((mem / 1024))

# Output JSON for Waybar
echo " ${cpu}%  ${mem_mb}MB"

