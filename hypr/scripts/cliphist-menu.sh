#!/bin/bash

# --- Configuración ---
HISTORIAL_LIMITE=50 # Define cuántas entradas quieres mostrar en Wofi

# --- Lógica del Menú ---

# Añadimos la opción de limpiar al principio de la lista
opcion_limpiar="󰆴 Limpiar Historial"

# Obtenemos la lista del historial, la limitamos y la combinamos con la opción de limpiar
opciones=$( (echo "$opcion_limpiar"; cliphist list | head -n $HISTORIAL_LIMITE) | wofi --dmenu -i --prompt="Portapapeles:")

# --- Lógica de Selección ---

# Si no se selecciona nada (se pulsa Escape), salimos
if [[ -z "$opciones" ]]; then
    exit 0
fi

# Comprobamos si la opción seleccionada es la de limpiar
if [[ "$opciones" == "$opcion_limpiar" ]]; then
    # Si es así, borramos el historial y enviamos una notificación
    cliphist wipe
    notify-send "Portapapeles" "Historial limpiado."
else
    # Si no, es una entrada normal. La decodificamos y la copiamos.
    echo "$opciones" | cliphist decode | wl-copy
    notify-send "Portapapeles" "Elemento copiado."
fi