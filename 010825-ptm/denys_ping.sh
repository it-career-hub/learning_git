#!/bin/bash

read -p "Введите адрес: " TARGET
[ -z "$TARGET" ] && exit 1

FAIL=0
while true; do
    TIME=$(ping -c 1 -W 2 "$TARGET" 2>/dev/null | grep -oP 'time=\K[0-9.]+')
    if [ $? -ne 0 ]; then
        ((FAIL++))
        echo "Ошибка пинга ($FAIL/3)"
        [ $FAIL -ge 3 ] && echo "3 НЕУДАЧИ ПОДРЯД!" && FAIL=0
    else
        [ -n "$TIME" ] && [ "${TIME%.*}" -gt 100 ] && echo "Пинг >100 мс: $TIME"
        FAIL=0
    fi
    sleep 1
done