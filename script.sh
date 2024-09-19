#!/bin/bash

 for i in {1..10};

 do

 

date +"%H:%M:%S"

ps -e | wc -l

 sleep 2

done

 

cat /proc/cpuinfo > cpuinfo.txt

 

grep '^NAME=Alpine Linux' /etc/os-release > osname.txt

grep '^NAME=' /etc/os-release | awk -F= '{print $2}' | tr -d '"' > newosname.txt

 

for ((i=50; i<=100; i++));

do

 

touch "${i}.txt"

done
