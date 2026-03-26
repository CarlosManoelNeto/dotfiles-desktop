#!/bin/bash
tmpfile=$(mktemp --suffix=.png)
grim "$tmpfile" && wl-copy < "$tmpfile" && notify-send -i "$tmpfile" "Screenshot" "Tela copiada para a área de transferência"
