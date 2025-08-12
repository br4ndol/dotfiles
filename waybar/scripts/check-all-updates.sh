#!/bin/bash

# Aseguramos que los comandos existan para evitar errores
if ! command -v waybar-module-pacman-updates &> /dev/null || ! command -v flatpak &> /dev/null; then
    echo "{\"text\": \"Error\", \"tooltip\": \"Dependencias no encontradas\", \"class\": \"critical\"}"
    exit
fi

# El resto del script es el mismo
pacman_aur_output=$(waybar-module-pacman-updates --tooltip-align-columns)
pacman_aur_count=$(echo "$pacman_aur_output" | sed '/^\s*$/d' | wc -l)

flatpak_updates=$(flatpak remote-ls --updates | wc -l)

total_updates=$((pacman_aur_count + flatpak_updates))

if [[ "$total_updates" -gt 0 ]]; then
    TOOLTIP="$pacman_aur_output"
    if [[ "$flatpak_updates" -gt 0 ]]; then
        TOOLTIP+="\n\nFlatpak: $flatpak_updates"
    fi
    
    echo "{\"text\": \"$total_updates\", \"tooltip\": \"$TOOLTIP\", \"class\": \"has-updates\"}"
else
    echo "{\"text\": \"0\", \"tooltip\": \"Sistema actualizado\", \"class\": \"updated\"}"
fi