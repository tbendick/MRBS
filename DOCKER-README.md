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


## Version

Current Docker package version: **1.4.2**

## Required Portainer environment variables

Use the same database password for `MRBS_DB_PASSWORD`; the app will use it to connect as the MRBS database user. `MYSQL_ROOT_PASSWORD` is also passed to the app container so first startup can create/check the database user and permissions.

```env
MRBS_HTTP_PORT=8080
PHPMYADMIN_PORT=8888
MRBS_TIMEZONE=America/New_York
MRBS_DB_SYSTEM=mysql
MRBS_DB_HOST=db
MRBS_DB_DATABASE=mrbs
MRBS_DB_USER=mrbs
MRBS_DB_PASSWORD=mrbs12345
MYSQL_ROOT_PASSWORD=root12345
MRBS_DB_TBL_PREFIX=mrbs_
MRBS_LOAD_SAMPLE_BOOKINGS=0
```

For first testing, use simple passwords with no special characters. After it starts cleanly, change them to stronger values and redeploy with a fresh database volume if needed.

## Portainer Environment Variables

For production, set these in the Portainer stack environment variables:

```env
MRBS_DB_DATABASE=mrbs
MRBS_DB_USER=mrbs
MRBS_DB_PASSWORD=change-this-password
MYSQL_ROOT_PASSWORD=change-this-root-password
MRBS_HTTP_PORT=8080
PHPMYADMIN_PORT=8888
MRBS_TIMEZONE=America/New_York
```

If the app log stays at `Waiting for MySQL at db...` after changing passwords, remove the old `mrbs_mysql_data` volume and redeploy. MySQL only creates users/passwords on the first initialization of a new database volume.

Version: 1.4.3
