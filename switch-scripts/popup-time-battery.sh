#!/bin/dash
# pops up a message in cinnamon
BAT=/sys/class/power_supply/BAT0/capacity
notify-send "$(date), bat = $(cat $BAT)"
