#!/bin/bash

if [ -z "$1" ]; then
    read -p "Введите адрес для ping: " HOST
else
    HOST="$1"
fi

fail_count=0

while true
do
    result=$(ping -c 1 "$HOST" 2>/dev/null)

    if [ $? -eq 0 ]; then
        fail_count=0

        ping_time=$(echo "$result" | awk -F'time=' '/time=/{print $2}' | awk '{print $1}')

        echo "Ping to $HOST: ${ping_time} ms"

        if [ -n "$ping_time" ]; then
            if awk -v t="$ping_time" 'BEGIN {exit !(t > 100)}'; then
                echo "Внимание: время пинга больше 100 мс: ${ping_time} ms"
            fi
        fi
    else
        fail_count=$((fail_count + 1))
        echo "Ping failed. Ошибка номер $fail_count подряд"

        if [ "$fail_count" -ge 3 ]; then
            echo "Внимание: ping не удался 3 раза подряд для адреса $HOST"
        fi
    fi

    sleep 1
done
