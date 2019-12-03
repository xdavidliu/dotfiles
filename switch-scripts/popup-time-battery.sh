#!/bin/dash
# pops up a message in cinnamon
BAT=/sys/class/power_supply/BAT0/capacity
if [ -f "$BAT" ]; then
  notify-send "$(date), bat = $(cat $BAT)"
else
  notify-send "$(date)"
fi
