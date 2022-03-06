#!/usr/bin/env bash

# From https://github.com/polybar/polybar/issues/763#issuecomment-445266024
killall -q polybar
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Adapted from https://github.com/polybar/polybar/issues/763#issuecomment-331604987
if type "xrandr"; then
  IFS=$'\n'
  for line in $(xrandr --listactivemonitors | tail --lines=+2); do
    monitor=$(echo "$line" | awk '{print $4}')
    if echo "$line" | grep --silent '+\*'; then
      # primary
      tray_position=right
    else
      tray_position=none
    fi
    echo "$monitor": "$tray_position"
    TRAY_POSITION=$tray_position MONITOR=$monitor polybar \
      --reload \
      --quiet \
      example \
      &
  done
fi

echo "Bars launched..."
