# Docker setup

1. Copy the sample environment file and set strong passwords:

```bash
cp .env.example .env
```

2. Start the stack:

```bash
docker compose up -d --build
```

3. Open the app:

```text
http://localhost:8080
```

phpMyAdmin is available at:

```text
http://localhost:8888
```

## What Docker creates

The app container now checks the database on startup. If the MRBS tables do not exist, it imports `tables.my.sql` automatically and then loads the FDNY room seed file. Sample bookings are not loaded by default. Set this in `.env` to load them when the schema is first created:

```env
MRBS_LOAD_SAMPLE_BOOKINGS=1
```

## Passwords

Database passwords are read from `.env`:

```env
MYSQL_PASSWORD=change-me-to-a-strong-password
MYSQL_ROOT_PASSWORD=change-root-to-a-strong-password
```

The PHP MRBS config receives the database password through the Docker environment variable `MRBS_DB_PASSWORD`, which is mapped from `MYSQL_PASSWORD` in `docker-compose.yml`.

## If you already started the old Docker version

MySQL only initializes an empty database volume once. This version also checks for missing MRBS tables from the app container, but if you want a completely fresh database, run:

```bash
docker compose down -v
docker compose up -d --build
```

Warning: `docker compose down -v` deletes the MySQL volume and all saved booking data.
