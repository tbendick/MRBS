# Docker quick start

This package is set up to run MRBS with Apache/PHP and MySQL using Docker Compose.

## 1. Configure

Copy the sample environment file and update the passwords:

```bash
cp .env.example .env
```

Recommended production changes in `.env`:

```env
MYSQL_PASSWORD=use-a-strong-password
MYSQL_ROOT_PASSWORD=use-a-different-strong-password
MRBS_HTTP_PORT=8080
MRBS_TIMEZONE=America/New_York
```

## 2. Start

From the project root:

```bash
docker compose up -d --build
```

Open:

- MRBS: http://localhost:8080
- phpMyAdmin: http://localhost:8888

phpMyAdmin login uses the values from `.env`:

- Server: `db`
- Username: `MYSQL_USER`
- Password: `MYSQL_PASSWORD`

## 3. Stop

```bash
docker compose down
```

## 4. Reset database

This deletes the MySQL data volume and rebuilds the starting database from `tables.my.sql` and the seed files.

```bash
docker compose down -v
docker compose up -d --build
```

## Notes

- The new intake admin field tables are included in `tables.my.sql` for fresh Docker installs.
- Existing installs are still protected by the PHP schema check in `web/event_requests.inc`, which creates missing intake tables automatically.
- The app container uses `docker-config.inc.php`, which reads database settings from environment variables.
