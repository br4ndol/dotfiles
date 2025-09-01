#!/bin/bash

    # Identificador del bus I2C de su monitor externo (ddcutil detect : I2C bus:  /dev/i2c-13) 
    BUS=13

    # Cantidad a cambiar en cada paso
    STEP=10

    case "$1" in
        up)
            ddcutil --bus $BUS setvcp 10 + $STEP
            ;;
        down)
            ddcutil --bus $BUS setvcp 10 - $STEP
            ;;
        *)
            echo "Uso: $0 {up|down}"
            exit 1
            ;;
    esac