#!/bin/sh

## set up the two monitors
## NOTE This is a simplistic approach because I already know the settings I
## want to apply.
my_laptop_external_monitor=$(xrandr --query | grep -ow 'DP-1 connected')
if [[ $my_laptop_external_monitor = *connected* ]]; then
	xrandr --output DP-1 --primary --mode 3440x1440 --rate 100 --output eDP-1 --off &
else
	xrandr --output eDP-1 --mode 3840x2400 --dpi 192 --rate 60 &
fi

counter=0
i3-msg -t get_workspaces | tr ',' '\n' | sed -nr 's/"name":"([^"]+)"/\1/p' | while read -r name; do
  printf 'ws-icon-%i = "%s;"\n' $((counter++)) $name
done
