#!/usr/bin/env bash

sketchybar --set "$NAME" icon="" label="$(ps -A -o %mem | awk '{s+=$1} END {s /= 8} END {printf "%.1f%%\n", s}')"
