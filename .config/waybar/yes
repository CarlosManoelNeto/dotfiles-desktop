#!/usr/bin/env bash

# Conta updates do pacman
PACMAN_UPDATES=$(checkupdates 2>/dev/null | wc -l)

# Conta updates do yay (AUR)
YAY_UPDATES=$(yay -Qua 2>/dev/null | wc -l)

TOTAL=$((PACMAN_UPDATES + YAY_UPDATES))

if [ "$TOTAL" -gt 0 ]; then
  echo "{\"text\": \" $TOTAL\", \"tooltip\": \"Pacman: $PACMAN_UPDATES\nAUR: $YAY_UPDATES\"}"
else
  echo ""
fi
