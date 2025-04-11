#!/bin/bash
BRIGHTNESS=$(brightnessctl get)
MAX_BRIGHTNESS=$(brightnessctl max)
PERCENTAGE=$(( BRIGHTNESS * 100 / MAX_BRIGHTNESS ))

notify-send "Brightness: $PERCENTAGE%" -h int:value:$PERCENTAGE

