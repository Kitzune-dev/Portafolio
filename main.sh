#!/bin/bash

# =================================================================
# Proyecto: Escaneo Automatizado Kali - Kitzune-dev
# Descripción: Herramienta de auditoría con menú interactivo
# Fecha: Enero 2026
# =================================================================

# Importar funciones secundarias (si existen)
[ -f scripts/utils.sh ] && source scripts/utils.sh

# Colores para la interfaz
VERDE='\033[0;32m'
AZUL='\033[0;34m'
ROJO='\033[0;31m'
NC='\033[0m' # No Color

mostrar_banner() {
    clear
    echo -e "${AZUL}==========================================${NC}"
    echo -e "${VERDE}      KITZUNE-DEV AUDIT TOOL 2026       ${NC}"
    echo -e "${AZUL}==========================================${NC}"
}

menu_principal() {
    while true; do
        mostrar_banner
        echo -e "1) ${VERDE}Análisis de Red${NC} (IPs y Puertos)"
        echo -e "2) ${VERDE}Auditoría de Tráfico${NC} (TShark)"
        echo -e "3) ${VERDE}Multimedia${NC} (Streaming VLC)"
        echo -e "4) ${ROJO}Salir${NC}"
        echo -e "${AZUL}------------------------------------------${NC}"
        read -p "Selecciona una opción [1-4]: " opcion

        case $opcion in
            1)
                echo -e "\n[*] Analizando red local..."
                ip a | grep "inet "
                read -p "Presiona Enter para volver..."
                ;;
            2)
                echo -e "\n[*] Iniciando captura rápida de paquetes (5 seg)..."
                sudo tshark -i eth0 -a duration:5
                read -p "Presiona Enter para volver..."
                ;;
            3)
                echo -e "\n[*] Abriendo flujo de video..."
                vlc --no-video-title-show v4l2:///dev/video0 &
                ;;
            4)
                echo -e "\n${VERDE}[!] Saliendo... ¡Feliz auditoría, Kitzune!${NC}"
                exit 0
                ;;
            *)
                echo -e "\n${ROJO}[!] Opción no válida.${NC}"
                sleep 2
                ;;
        esac
    done
}

# Ejecutar el menú
menu_principal
