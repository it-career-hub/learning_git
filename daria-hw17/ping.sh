#!/bin/sh

HOST="$1"           
if [ -z "$HOST" ]; then
  echo "Add address:"
  read HOST
fi

FAILS=0

while true; do

  if ping -c 1 -W 1 "$HOST" > ping.log 2>&1; then
    FAILS=0
    TIME=$(grep "time=" ping.log | cut -d "=" -f4 | cut -d " " -f1)
    echo "Answer: $TIME ms"
    if [ "$(echo "$TIME > 100" | bc)" -eq 1 ]; then
      echo "Ping more 100 ms!"
    fi
  else
    FAILS=$((FAILS+1))
    echo "No answer ($FAILS)"
    if [ $FAILS -ge 3 ]; then
      echo "Three bed pings!"
      FAILS=0
    fi
  fi
  sleep 1
done
