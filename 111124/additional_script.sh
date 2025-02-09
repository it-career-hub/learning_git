#!/bin/bash

openfile() {                                    #как аргумент указываем файл для открытия

    echo "This file has been opened through bash script: '$1' "

    cat $1                                      #$1 указывает на номер аргумента заданого для функции
           }



#created a branch


