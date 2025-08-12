#!/bin/bash
PLAYER_STATUS=$(playerctl status 2>/dev/null)
if [[ "$PLAYER_STATUS" == "Playing" ]]; then
    echo "⏸"
else
    echo "▶"
fi