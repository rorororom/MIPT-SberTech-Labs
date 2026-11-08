```sh
./setup.sh
docker compose up -d --build
docker compose exec master ansible-playbook playbook.yml
```

```sh
docker compose ps
curl --fail -i http://localhost:8081/health
```

```sh
docker compose down
```

![Контейнеры](HW_3/evidence/containers.jpg)
![HTTP 200](HW_3/evidence/health.jpg)
