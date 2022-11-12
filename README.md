# this is rails 7 basic docker playground
```bash
docker build .
docker compose run --no-deps web rails new . --force --database=postgresql
docker compose build
docker compose up
```