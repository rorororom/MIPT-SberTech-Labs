#!/usr/bin/env bash

if [ "$#" -ne 2 ] || [ -z "$2" ]; then
    echo "Нужно: <лог-файл> <слово>" >&2
    exit 1
fi

if [ ! -f "$1" ] || [ ! -r "$1" ]; then
    echo "Пупупу, не читается файл: $1" >&2
    exit 1
fi

grep -F -- "$2" "$1" > errors.txt

if [ "$?" -gt 1 ]; then
    echo "Пупупу, ошибка поиска" >&2
    exit 1
fi

echo "В итоге строк: $(wc -l < errors.txt | tr -d ' ')" > count.txt