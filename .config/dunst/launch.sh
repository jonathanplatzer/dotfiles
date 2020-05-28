#!/bin/bash

source "$HOME/.cache/wal/colors.sh"

dunst \
    -lb "${color0:-#FFFFFF}" \
    -nb "${color0:-#FFFFFF}" \
    -cb "${color0:-#FFFFFF}" \
    -lf "${color15:-#000000}" \
    -bf "${color15:-#000000}" \
    -cf "${color15:-#000000}" \
    -nf "${color15:-#000000}"
