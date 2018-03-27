#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar for all connected screens
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    case $m in
        VGA-1) /usr/bin/polybar vga & ;;
        LVDS-1) /usr/bin/polybar example & ;;
    esac
done

echo "Bars launched..."
