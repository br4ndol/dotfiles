#!/bin/bash

COUNT=$(swaync-client -c)
DND=$(swaync-client -dnd)

# Lógica para el icono y la clase
if [[ "$DND" == "true" ]]; then
    ICON=""
    CLASS="dnd"
else
    ICON=""
    if [[ "$COUNT" -gt 0 ]]; then
        CLASS="notification"
    else
        CLASS="none"
    fi
fi

# ESTA ES LA LÓGICA NUEVA Y CORREGIDA:
# Si el contador es mayor que cero, la variable TEXT es el número.
# Si no, la variable TEXT está vacía.
if [[ "$COUNT" -gt 0 ]]; then
    TEXT="$COUNT"
else
    TEXT=""
fi

# Formatea la salida en JSON. Ahora 'text' estará vacío cuando no haya notificaciones.
echo "{\"text\": \"$TEXT\", \"tooltip\": \"Notificaciones: $COUNT\", \"class\": \"$CLASS\", \"alt\": \"$ICON\"}"