#!/usr/bin/env bash

HOSTNAME_VAL=$(hostname)
USER_VAL=$(whoami)
UPTIME_VAL=$(uptime -p | sed 's/^up //')

TOTAL_RAM=$(free -m | awk '/^Mem:/ {print $2}')
AVAIL_RAM=$(free -m | awk '/^Mem:/ {print $7}')

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$DISK_USAGE" -gt 80 ]; then
    DISK_STATUS="WARNING: High disk usage"
else
    DISK_STATUS="Disk Status: OK"
fi

if command -v docker >/dev/null 2>&1; then
    DOCKER_STATUS="Installed"
else
    DOCKER_STATUS="Not Installed"
fi

{
    echo "===== SYSTEM MONITOR ====="
    echo "Hostname: $HOSTNAME_VAL"
    echo "User: $USER_VAL"
    echo "Uptime: $UPTIME_VAL"
    echo "Total RAM: ${TOTAL_RAM} MB"
    echo "Available RAM: ${AVAIL_RAM} MB"
    echo "Disk Usage: ${DISK_USAGE}%"
    echo "$DISK_STATUS"
    echo "Docker: $DOCKER_STATUS"
    echo "=========================="
} | tee system_report.log
