#!/bin/bash

# espera o swww-daemon subir
sleep 1

WALLPAPERS=(
#  "/home/carlos/wallpapers/gruvbox_image46.png"
  "/home/carlos/wallpapers/finalizer.png"
#  "/home/carlos/wallpapers/elias.jpg"
  "/home/carlos/wallpapers/5b1iuo0xlth61.png"
)

WP1=$(shuf -n 1 -e "${WALLPAPERS[@]}")
WP2=$(shuf -n 1 -e "${WALLPAPERS[@]}")

swww img "$WP1" \
  --outputs DP-1 \
  --transition-type grow \
  --transition-duration 1.2 \
  --transition-fps 60

swww img "$WP2" \
  --outputs DP-2 \
  --transition-type grow \
  --transition-duration 1.2 \
  --transition-fps 60
