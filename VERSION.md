# MRBS Classroom Booking

Current Version: 1.4.2

## 1.4.2
- Fixed Docker/Portainer database startup reliability.
- App container now receives `MYSQL_ROOT_PASSWORD` so it can create/repair the MRBS database user and grants if needed.
- Startup now creates the MRBS database and user if missing, then imports MRBS tables if missing.
- Added clearer startup error message if database connection still fails.

## 1.4.1
- Fixed Docker environment variable naming for `MRBS_DB_*` values.

## 1.4.0
- Added Event flag to intake requests.
- Added Event Calendar Report with past events marked.

## 1.3.0
- Added Docker schema initialization.
- Moved DB credentials to environment variables.
