#!/bin/bash
tmpfile=$(mktemp --suffix=.png)
grim -g "$(slurp)" "$tmpfile" && wl-copy < "$tmpfile" && notify-send -i "$tmpfile" "Screenshot" "Área copiada para a área de transferência"
