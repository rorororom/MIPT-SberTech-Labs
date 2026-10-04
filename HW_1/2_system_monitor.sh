#!/bin/bash

PID_FILE=".monitor.pid"

case "${1:-}" in
START)
    if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        echo "Уже запущен"
        exit 1
    fi

    (
        while true; do
            file="system_report_$(date +%F).csv"

            if [ ! -f "$file" ]; then
                echo 'timestamp;all_memory;free_memory;%memory_used;%cpu_used;%disk_used;load_average_1m' > "$file"
            fi

            memory=$(free -m | awk '/^Mem:/ { printf "%s;%s;%.2f", $2, $4, ($2-$4)*100/$2 }')
            cpu=$(top -bn1 | awk '/Cpu\(s\)/ { print 100-$8 }')
            disk=$(df -P / | awk 'NR == 2 { print $5 }')
            load=$(uptime | awk -F'load average: ' '{ print $2 }' | cut -d, -f1)

            echo "$(date '+%Y-%m-%d %H:%M:%S');$memory;$cpu;$disk;$load" >> "$file"
            sleep 600
        done
    ) >/dev/null 2>&1 &

    echo $! > "$PID_FILE"
    echo "Запущен (PID: $(cat "$PID_FILE"))"
    ;;

STATUS)
    if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        echo "запущен (PID: $(cat "$PID_FILE"))"
    else
        echo "не запущен"
    fi
    ;;

STOP)
    if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
        kill "$(cat "$PID_FILE")"
        rm -f "$PID_FILE"
        echo "Остановлен"
    else
        echo "Не запущен"
    fi
    ;;

*)
    echo "Использование: $0 START|STATUS|STOP"
    exit 1
    ;;
esac
