#!/bin/bash  

# Запрашиваем у пользователя адрес для пинга  
read -p "Введите адрес для пинга: " host  

# Переменные для отслеживания неудачных попыток  
consecutive_failures=0  

while true; do  
    # Выполняем пинг и извлекаем время ответа  
    ping_output=$(ping -c 1 "$host" 2>&1)  
    
    if [[ $? -ne 0 ]]; then  
        # Если пинг не удался  
        consecutive_failures=$((consecutive_failures + 1))  
        echo "Не удалось выполнить пинг. Попытка $consecutive_failures/3."  
    else  
        # Извлекаем время пинга из вывода  
        ping_time=$(echo "$ping_output" | grep 'time=' | sed -E 's/.*time=([0-9.]+) ms/\1/')  
        
        # Проверяем, превышает ли время пинга 100 мс  
        if (( $(echo "$ping_time > 100" | bc -l) )); then  
            echo "Время пинга: $ping_time мс (превышает 100 мс)."  
        else  
            echo "Время пинга: $ping_time мс."  
        fi  
        
        # Сбрасываем счетчик неудачных попыток  
        consecutive_failures=0  
    fi  

    # Проверяем, не достигли ли мы 3 последовательных неудачных попыток  
    if (( consecutive_failures >= 3 )); then  
        echo "Не удалось выполнить пинг в течение 3 последовательных попыток."  
        break  
    fi  

    # Ждем 1 секунду перед следующей попыткой  
    sleep 1  
done
