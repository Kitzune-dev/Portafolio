#!/bin/bash/source $(dirname "$0")/utils.sh


# =================================================================
# Funciones Avanzadas para Kitzune-dev Audit Tool
# =================================================================

# Función para escanear dispositivos vivos en la red actual
escaneo_red_viva() {
    local rango_red=$(ip -o -4 addr show | awk '{print $4}' | grep -v "127.0.0.1" | head -n 1)
    echo -e "\n${AZUL}[*] Detectando dispositivos en: $rango_red${NC}"
    
    if command -v nmap &> /dev/null; then
        nmap -sn "$rango_red" | grep "Nmap scan report"
    else
        echo -e "${ROJO}[!] Nmap no está instalado.${NC}"
    fi
}

# Función para verificar si un puerto específico está abierto en una IP
chequear_puerto() {
    read -p "Introduce la IP de destino: " target_ip
    read -p "Introduce el puerto (ej: 80, 443, 8080): " target_port
    
    (echo >/dev/tcp/"$target_ip"/"$target_port") &>/dev/null && \
    echo -e "${VERDE}[+] El puerto $target_port está ABIERTO en $target_ip${NC}" || \
    echo -e "${ROJO}[-] El puerto $target_port está CERRADO${NC}"
}

# Función para capturar tráfico DNS (útil para ver a dónde se conecta un dispositivo)
capturar_dns_kitzune() {
    echo -e "${AZUL}[*] Capturando consultas DNS en tiempo real (Ctrl+C para parar)...${NC}"
    sudo tshark -i any -Y "dns.flags.response == 0" -T fields -e dns.qry.name
}

# Función para limpiar archivos temporales de logs
limpiar_sistema() {
    echo -e "${AZUL}[*] Limpiando archivos temporales de auditoría...${NC}"
    rm -rf ./reports/*.tmp
    echo -e "${VERDE}[DONE] Limpieza completada.${NC}"
}
