#!/bin/bash

# --- CONFIGURAÇÃO DE NOMES ---
# Copie os nomes técnicos do 'pactl list short sinks' aqui:
SINK_A="alsa_output.pci-0000_07_00.6.analog-stereo" # Exemplo: Fone
SINK_B="alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"   # Exemplo: Monitor/Caixas



# Defina os nomes que aparecerão na notificação:
NOME_A="🎧 Fone de Ouvido"
NOME_B="🔊 Caixas de Som"
# -----------------------------

# Pega a saída atual
ATUAL=$(pactl get-default-sink)

# Lógica de troca e definição do nome amigável
if [ "$ATUAL" == "$SINK_A" ]; then
    NOVA_SAIDA="$SINK_B"
    EXIBIR="$NOME_B"
else
    NOVA_SAIDA="$SINK_A"
    EXIBIR="$NOME_A"
fi

# Executa a troca
pactl set-default-sink "$NOVA_SAIDA"

# Move o áudio que já está tocando para a nova saída
pactl list short sink-inputs | cut -f 1 | while read stream; do
    pactl move-sink-input "$stream" "$NOVA_SAIDA"
done

# Notificação com nome bonito
notify-send -i audio-speakers-symbolic "Saída de Áudio" "Ativo: $EXIBIR" -t 2000 --replace-id=2