#!/bin/bash
read -p "Enter address: " address
fail_count=0
while true
do
ping -c 1 $address > ping_output.txt 2>&1
if grep -q "time=" ping_output.txt; then
        time=$(grep "time=" ping_output.txt | awk -F'time=' '{print $2}' | awk '{print $1}' | cut -d'.' -f1)

        if [ "$time" -gt 100 ]; then
            echo "Ping is slow: ${time} ms"
        fi

        fail_count=0
    else
        fail_count=$((fail_count + 1))
        echo "Ping failed ($fail_count)"

        if [ "$fail_count" -ge 3 ]; then
            echo "Ping failed 3 times"
        fi
    fi

    sleep 1
done