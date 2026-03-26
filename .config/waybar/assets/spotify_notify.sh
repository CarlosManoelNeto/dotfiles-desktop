#!/bin/bash

PLAYER="spotify"
LAST_ID=""
COVER="/tmp/spotify_cover.jpg"

while true; do
    STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)

    if [[ "$STATUS" != "Playing" ]]; then
        sleep 1
        continue
    fi

    TITLE=$(playerctl -p "$PLAYER" metadata title)
    ARTIST=$(playerctl -p "$PLAYER" metadata artist)
    ART_URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl)
    TRACK_ID="$TITLE-$ARTIST"

    # Só notifica se a música mudou
    if [[ "$TRACK_ID" != "$LAST_ID" ]]; then
        LAST_ID="$TRACK_ID"

        if [[ "$ART_URL" == http* ]]; then
            curl -sL "$ART_URL" -o "$COVER"
            ICON="$COVER"
        else
            ICON="audio-x-generic"
        fi

        notify-send \
            -i "$ICON" \
            "Tocando agora:" \
            "$TITLE\n<i>$ARTIST</i>" \
            -t 3000 \
            --replace-id=999
    fi

    sleep 1
done
