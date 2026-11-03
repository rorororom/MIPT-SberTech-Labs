# HW-3 — Docker Compose

Nginx → Python-приложение → PostgreSQL. Приложение показывает счётчик посещений,
который хранится в БД.

## Запуск

Нужны Docker с Compose v2+ и свободный порт 80. Из корня репозитория:

```sh
cp .env.example .env
# Задайте свой POSTGRES_PASSWORD в .env.
docker compose up -d
```

Откройте http://localhost — каждое обращение увеличивает счётчик на единицу.
`.env` исключён из Git; в `.env.example` настоящего пароля нет.

## Сети и данные

- `nginx` подключён к `frontend`, публикует единственный порт `80:80`.
- `app` подключён к `frontend` и `backend`, порты не публикует.
- `db` подключён только к внутренней сети `backend`, порты не публикует.
- Том `pgdata` хранит данные PostgreSQL. `HW_3/init.sql` выполняется при первом запуске.
- Healthcheck обеспечивает запуск в порядке БД → приложение → Nginx.

## Проверка

```sh
docker compose ps
curl --fail http://localhost/
docker compose restart
docker compose up -d --wait
curl --fail http://localhost/
docker compose down
docker compose up -d --wait
curl --fail http://localhost/
```

Счётчик продолжает расти после перезапуска и пересоздания контейнеров.
В `docker compose ps` только у Nginx есть публикация порта со стрелкой `->`.
Остановка: `docker compose down`. Не добавляйте `--volumes`, если хотите сохранить БД.

В файле указана версия `3.8` по заданию. Современный Compose может предупреждать
об устаревшем поле `version`; запуску это не мешает
([Docker Docs](https://docs.docker.com/reference/compose-file/version-and-name/)).
