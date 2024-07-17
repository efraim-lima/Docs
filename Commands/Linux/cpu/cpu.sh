#!/bin/bash
# This script monitors CPU and memory usage

THRESHOLD=80

send_alert() {
	MSG="$1"
	echo "ALERTA: $MSG"
	
	# ativando notificação do sistema
	notify-send "ALERTA" "$MSG"
	
	# criando log no sistema
	logger -p user.notice "System alert: $MSG"
	
	# limpando cache
	sudo sync
	sudo sysctl -w vm.drop_caches=3
}

check_memory() {
	# Get the current usage of memory
	RAM_USAGE=$(free -m | awk '/Mem/ {printf("%.0f", $3/$2*100)}')
	CACHE_USAGE=$(free -m | awk '/Mem/ {printf("%.0f", $6/$2*100)}')

	if (( $(echo "$RAM_USAGE > $THRESHOLD" | bc -l) )); then
	send_alert "Uso de RAM alto: ${RAM_USAGE}%"
	fi

	if (( $(echo "$CACHE_USAGE > $THRESHOLD" | bc -l) )); then
	send_alert "Uso de cache alto: ${CACHE_USAGE}%"
	fi
}

while :
do
	# Print the usage
	# Sleep for 1 second
	check_memory
	sleep 60
done
