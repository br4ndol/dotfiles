#!/bin/bash

# Comprueba si hay algún reproductor activo
PLAYER_STATUS=$(playerctl status 2>/dev/null)

if [[ "$PLAYER_STATUS" == "Playing" || "$PLAYER_STATUS" == "Paused" ]]; then
    # Obtiene los metadatos
    TITLE=$(playerctl metadata --format "{{title}}")
    ARTIST=$(playerctl metadata --format "{{artist}}")
    ALBUM=$(playerctl metadata --format "{{album}}")

    # Trunca el texto para que no se salga del widget
    TITLE_TRUNC=$(echo "$TITLE" | cut -c1-40)
    ARTIST_TRUNC=$(echo "$ARTIST" | cut -c1-40)
    ALBUM_TRUNC=$(echo "$ALBUM" | cut -c1-40)

    # Formatea la salida con Pango Markup. Esta es la salida que hyprlock renderizará.
    echo "<b>$TITLE_TRUNC</b><br/><small>$ARTIST_TRUNC</small><br/><small>$ALBUM_TRUNC</small>"
else
    # Si no hay nada, no devuelve NADA. Esto hará que el widget se oculte.
    echo ""
fi