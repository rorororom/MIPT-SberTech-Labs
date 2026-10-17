#!/usr/bin/env bash
set -e

if [ "$#" -ne 3 ]; then
    echo "Нужно вводить: <ссылка> <ветка1> <ветка2>" >&2
    exit 1
fi

dir=$(mktemp -d)
trap 'rm -rf "$dir"' EXIT

git clone --bare "$1" "$dir/repo"

git -C "$dir/repo" diff --name-status --no-renames \
    "refs/heads/$2" "refs/heads/$3" > "$dir/files"

{
    echo "Различия между ветками"
    echo "Репозиторий: $1"
    echo "Ветка 1: $2"
    echo "Ветка 2: $3"
    echo "Дата: $(date '+%Y-%m-%d %H:%M:%S')"
    echo
    echo "Файлы:"

    if [ -s "$dir/files" ]; then
        cat "$dir/files"
    else
        echo "Нет изменений"
    fi

    echo
    echo "Итого:"
    echo "Всего: $(wc -l < "$dir/files" | tr -d ' ')"
    echo "Добавлено: $(grep -c '^A' "$dir/files" || true)"
    echo "Удалено: $(grep -c '^D' "$dir/files" || true)"
    echo "Изменено: $(grep -c '^[MT]' "$dir/files" || true)"
} > "diff_report_${2//\//_}_vs_${3//\//_}.txt"
