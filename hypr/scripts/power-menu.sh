#!/bin/bash

# Wofi Command
WOFI_CMD="wofi --dmenu -p 'Power Menu'"

# Options with icons
SHUTDOWN="⏻   Shutdown"
REBOOT="   Reboot"
LOCK="   Lock"
LOGOUT="󰍃   Logout"
SUSPEND="   Suspend"

# Present the options
CHOSEN=$(printf "%s\n%s\n%s\n%s\n%s" "$SHUTDOWN" "$REBOOT" "$LOCK" "$LOGOUT" "$SUSPEND" | $WOFI_CMD)

# Execute the chosen command
case "$CHOSEN" in
    "$SHUTDOWN")
        systemctl poweroff
        ;;
    "$REBOOT")
        systemctl reboot
        ;;
    "$LOCK")
        swaylock
        ;;
    "$LOGOUT")
        hyprctl dispatch exit
        ;;
    "$SUSPEND")
        systemctl suspend
        ;;
    *)
        # Handle escape key or empty selection
        exit 0
        ;;
esac
