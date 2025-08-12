#!/bin/bash

# Opciones del menú con iconos
opciones=" Apagar\n Reiniciar\n Bloquear\n Salir de Hyprland"

# Lanza Wofi en modo dmenu para mostrar las opciones
seleccion=$(echo -e "$opciones" | wofi --dmenu -i --prompt="Acción:")

# Ejecuta el comando correspondiente a la selección
case $seleccion in
    " Apagar")
        systemctl poweroff;;
    " Reiniciar")
        systemctl reboot;;
    " Bloquear")
        hyprlock;; # Usamos hyprlock que ya está configurado
    " Salir de Hyprland")
        hyprctl dispatch exit;;
esac