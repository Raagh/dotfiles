#!/usr/bin/env bash
# Simple laptop monitor (eDP-1) toggle script

set -e # Exit on error

# Check if eDP-1 is currently shown in monitors output (meaning it's enabled)
if hyprctl monitors | grep -q "Monitor eDP-1"; then
  echo "Disabling eDP-1..."
  hyprctl keyword monitor "eDP-1,disable"
else
  # eDP-1 is not shown (disabled), enable it
  echo "Enabling eDP-1..."

  # Check if ultrawide (DP-11 or DP-12) is connected
  if hyprctl monitors | grep -q "Monitor DP-1[12]"; then
    echo "Ultrawide detected - positioning eDP-1 to the right"
    hyprctl keyword monitor "eDP-1,2880x1800@120,3440x0,1.5"
  else
    echo "No ultrawide detected - positioning eDP-1 as primary"
    hyprctl keyword monitor "eDP-1,2880x1800@120,0x0,1.5"
  fi
fi
