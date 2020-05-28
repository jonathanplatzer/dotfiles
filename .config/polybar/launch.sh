#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Start new instances
polybar primary &
