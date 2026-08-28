#!/bin/bash

# Print time and number of processes 10 times
for i in {1..10}
do
    date +"%H:%M:%S"
    ps -ef | tail -n +2 | wc -l
    sleep 2
done

# CPU info to file
cat /proc/cpuinfo > cpuinfo.txt

# Full OS name with NAME=
cat /etc/os-release | grep ^NAME= > os_full_name.txt

# Only OS name
for i in {50..100}
do
    touch "${i}.txt"
done
