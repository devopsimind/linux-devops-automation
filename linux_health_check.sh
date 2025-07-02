#!/bin/bash

ALERT_EMAIL="admin@example.com"

cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
disk=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
mem=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100.0}')

if (( ${cpu%.*} > 80 )); then
  echo "High CPU usage: $cpu%" | mail -s "CPU Alert" $ALERT_EMAIL
fi

if (( disk > 90 )); then
  echo "Disk almost full: $disk%" | mail -s "Disk Alert" $ALERT_EMAIL
fi

if (( ${mem%.*} > 85 )); then
  echo "Memory usage high: $mem%" | mail -s "Memory Alert" $ALERT_EMAIL
fi
