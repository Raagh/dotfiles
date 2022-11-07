#!/usr/bin/env bash

## Files and Directories
DIR="$HOME/.config/bspwm/polybar"
SFILE="$DIR/system"
RFILE="$DIR/.system"
MFILE="$DIR/.module"

## Get system variable values for various modules
get_values() {
	CARD=$(basename "$(find /sys/class/backlight/* | head -n 1)")
	BATTERY=$(basename "$(find /sys/class/power_supply/*BAT* | head -n 1)")
	ADAPTER=$( "$(find /sys/class/power_supply/*AC* | head -n 1)")
	INTERFACE=$(ip link | awk '/state UP/ {print $2}' | tr -d :)
}

## Write values to `system` file
set_values() {
	if [[ "$ADAPTER" ]]; then
		sed -i -e "s/adapter = .*/adapter = $ADAPTER/g" "$SFILE"
	fi
	if [[ "$BATTERY" ]]; then
		sed -i -e "s/battery = .*/battery = $BATTERY/g" "$SFILE"
	fi
	if [[ "$CARD" ]]; then
		sed -i -e "s/graphics_card = .*/graphics_card = $CARD/g" "$SFILE"
	fi
	if [[ "$INTERFACE" ]]; then
		sed -i -e "s/network_interface = .*/network_interface = $INTERFACE/g" "$SFILE"
	fi
}

## Launch Polybar 
launch_bar() {
	CARD=$(basename "$(find /sys/class/backlight/* | head -n 1)")
	if [[ "$CARD" != *"intel_"* ]]; then
		if [[ ! -f "$MFILE" ]]; then
			sed -i -e 's/backlight/brightness/g' "$DIR"/config
			touch "$MFILE"
		fi
	fi
		
	if [[ ! $(pidof polybar) ]]; then
    my_laptop_external_monitor=$(xrandr --query | grep 'DP-3 connected')
    echo my_laptop_external_monitor
    if [[ $my_laptop_external_monitor = *connected* ]]; then
      polybar -q bar-left -c "$DIR"/config-widescreen &
      polybar -q bar-right -c "$DIR"/config-widescreen &
    else
      polybar -q bar-left -c "$DIR"/config-laptop &
      polybar -q bar-right -c "$DIR"/config-laptop &
    fi
	else
		polybar-msg cmd restart
	fi
}

# Execute functions
if [[ ! -f "$RFILE" ]]; then
	get_values
	set_values
	touch "$RFILE"
fi

launch_bar
