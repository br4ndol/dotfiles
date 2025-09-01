#!/bin/bash

# Directorio de capturas
DIR="$HOME/Pictures/Screenshots"
NAME="screenshot_$(date +%Y-%m-%d_%H%M%S).png"
FILE_PATH="${DIR}/${NAME}"

# Asegurarse de que el directorio exista
mkdir -p "$DIR"

# Menú de opciones de captura
capture_option=$(printf "  Fullscreen\n󱣴  Select Area\n  Active Window" | \
                 rofi -dmenu -p "Capture" -theme ~/.config/rofi/themes/screenshot.rasi)

# Si el usuario cancela, salir
if [ -z "$capture_option" ]; then
    exit 0
fi

# Esperar un breve instante para que Rofi se cierre
sleep 0.5

# Tomar la captura según la opción elegida
case "$capture_option" in
    "  Fullscreen")
        grim "$FILE_PATH"
        ;;
    "󱣴  Select Area")
        grim -g "$(slurp)" "$FILE_PATH"
        ;;
    "  Active Window")
        GEOMETRY=$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$GEOMETRY" "$FILE_PATH"
        ;;
esac

# Comprobar si la captura se realizó
if [ ! -f "$FILE_PATH" ]; then
    notify-send "Screenshot Canceled"
    exit 0
fi

# Menú de acciones post-captura
action_option=$(printf "󰆓  Save File\n  Edit with Swappy\n Copy to Clipboard" | \
                rofi -dmenu -p "Action" -theme ~/.config/rofi/themes/screenshot.rasi)

# Realizar la acción elegida
case "$action_option" in
    "󰆓  Save File")
        notify-send "Screenshot Saved" "Saved to ${NAME}" -i "$FILE_PATH"
        ;;
    "  Edit with Swappy")
        swappy -f "$FILE_PATH"
        ;;
    " Copy to Clipboard")
        wl-copy < "$FILE_PATH"
        notify-send "Screenshot Copied" "Image copied to clipboard." -i "$FILE_PATH"
        # Opcional: eliminar el fichero si solo se quería en el portapapeles
        # rm "$FILE_PATH"
        ;;
esac