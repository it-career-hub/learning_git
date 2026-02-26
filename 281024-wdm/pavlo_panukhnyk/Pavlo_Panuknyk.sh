#This file is Pavlos
#!/bin/bash

# Скрипт подсчета времени, проведенного пользователем на сервере

if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт с правами root."
  exit 1
fi

# Проверка наличия аргумента с именем пользователя
if [ -z "$1" ]; then
  echo "Использование: $0 <имя_пользователя>"
  exit 1
fi

USERNAME=$1

echo "Подсчет времени для пользователя: $USERNAME"

# Получение данных о сессиях пользователя из /var/log/wtmp
USER_SESSIONS=$(last -F $USERNAME | grep "$USERNAME" | grep -v "still logged in")

if [ -z "$USER_SESSIONS" ]; then
  echo "Не найдено записей для пользователя $USERNAME."
  exit 0
fi

# Инициализация общего времени
TOTAL_TIME=0

# Обработка каждой строки сессии
while IFS= read -r SESSION; do
  START=$(echo "$SESSION" | awk '{print $4, $5, $6, $7}')
  END=$(echo "$SESSION" | awk '{print $8, $9, $10, $11}')

  # Преобразование времени в секунды для подсчета разницы
  START_EPOCH=$(date -d "$START" +%s)
  END_EPOCH=$(date -d "$END" +%s)

  SESSION_TIME=$((END_EPOCH - START_EPOCH))
  TOTAL_TIME=$((TOTAL_TIME + SESSION_TIME))
done <<< "$USER_SESSIONS"

# Преобразование общего времени в часы, минуты и секунды
HOURS=$((TOTAL_TIME / 3600))
MINUTES=$(( (TOTAL_TIME % 3600) / 60 ))
SECONDS=$((TOTAL_TIME % 60))

echo "Общее время на сервере: ${HOURS}ч ${MINUTES}м ${SECONDS}с"

