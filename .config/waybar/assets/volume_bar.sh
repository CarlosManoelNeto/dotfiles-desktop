#!/bin/bash

# Pega a saída oficial
OUTPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

# Extrai o número (ex: 0.50) e remove o ponto para virar inteiro (50)
# Isso evita problemas de locale (ponto vs vírgula)
RAW_VOL=$(echo "$OUTPUT" | awk '{print $2}' | tr -d '.')
# Remove zeros à esquerda e garante que não seja vazio
VOLUME=$(echo "$RAW_VOL" | sed 's/^0*//')
[ -z "$VOLUME" ] && VOLUME=0
# Se o volume for algo como "5", vira "50" (ajuste para wpctl)
if [ ${#RAW_VOL} -eq 1 ]; then VOLUME=$((VOLUME * 10)); fi

MUTED="no"
[[ "$OUTPUT" == *"[MUTED]"* ]] && MUTED="yes"

# Desenho da barra
FILLED=$((VOLUME / 10))
[ "$FILLED" -gt 10 ] && FILLED=10
EMPTY=$((10 - FILLED))

if [ "$MUTED" = "yes" ]; then
    BAR="󰝟 "
else
    BAR=" "
fi

for ((i=0; i<FILLED; i++)); do BAR+="▮"; done
for ((i=0; i<EMPTY; i++)); do BAR+="▯"; done

echo "{\"text\": \"$BAR\", \"tooltip\": \"Volume: ${VOLUME}%\", \"class\": \"custom-wireplumber\"}"