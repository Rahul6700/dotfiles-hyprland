#!/bin/bash

MAX_LENGTH=30

status=$(playerctl status 2>/dev/null)

if [ "$status" = "Playing" ] || [ "$status" = "Paused" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    output="$artist - $title"

    # Truncate if too long
    if [ ${#output} -gt $MAX_LENGTH ]; then
        output="${output:0:$MAX_LENGTH}…"
    fi

    echo "$output"
else
    echo ""
fi

