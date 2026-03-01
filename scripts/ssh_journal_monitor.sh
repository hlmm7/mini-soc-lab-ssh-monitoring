#! /usr/bin/env bash

#==========================================================
# Script: monitor_ssh_bruteforce.sh
# Descripción: detecta intentos de fuerza bruta en SSH
# =========================================================


#--- Configuración ---
# intentos mínimos para alerta
THRESHOLD=${1:-5}
# Periodo de análisis
TIME_FRAME=${2:-"1 hour ago"}
LOG_SERVICE="ssh"

# Colores
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
green="\e[0;32m\033[1m"
yellow="\e[0;33m\033[1m"
nc="\033[0m\e[0m" # sin color

echo -e "\n-----------------------------------------------------------------------------------"
echo -e "${green}[+] Iniciando análisis de intentos fallidos${nc} ${yellow}(Límite: $THRESHOLD)${nc}${green}...${nc}"
echo -e "-----------------------------------------------------------------------------------\n"

echo "-----------------------------------------------------------------------------------"
echo -e "Periodo analizado: ${blue}$TIME_FRAME${nc}"
echo -e "Umbral de alerta: ${blue}$THRESHOLD intentos${nc}"
echo -e "-----------------------------------------------------------------------------------\n"

echo -e "-----------------------------------------------------------------------------------"
sudo journalctl -u "$LOG_SERVICE" --since "$TIME_FRAME" |
	grep "Failed password" |
	awk '{print $(NF-3)}' |
	sort | uniq -c | sort -nr |

while read -r count ip; do
if [ "$count" -ge "$THRESHOLD" ]; then
	echo -e "${red}[!] Alerta:${nc} ${blue}$ip${nc} superó el umbral con ${red}$count${nc} intentos fallidos"
else
	echo -e "Info:\t$ip tiene $count intentos (bajo el umbral)"
fi
done 

echo -e "-----------------------------------------------------------------------------------\n"
echo -e "${green}[+] Análisis finalizado${nc}\n"

