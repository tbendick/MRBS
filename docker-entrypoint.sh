#!/usr/bin/env bash
set -euo pipefail

: "${MRBS_DB_HOST:=db}"
: "${MRBS_DB_DATABASE:=mrbs}"
: "${MRBS_DB_USER:=mrbs}"
: "${MRBS_DB_PASSWORD:?MRBS_DB_PASSWORD is required. Set it in your .env file or Portainer stack variables.}"
: "${MRBS_DB_TBL_PREFIX:=mrbs_}"
: "${MYSQL_ROOT_PASSWORD:=}"

mysql_root_args=(
  --protocol=TCP
  --host="${MRBS_DB_HOST}"
  --user="root"
  --password="${MYSQL_ROOT_PASSWORD}"
)

mysql_app_args=(
  --protocol=TCP
  --host="${MRBS_DB_HOST}"
  --user="${MRBS_DB_USER}"
  --password="${MRBS_DB_PASSWORD}"
  "${MRBS_DB_DATABASE}"
)

sql_escape() {
  printf "%s" "$1" | sed "s/'/''/g"
}

wait_for_root=false
if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
  wait_for_root=true
fi

echo "Waiting for MySQL at ${MRBS_DB_HOST}..."
for i in $(seq 1 90); do
  if mysql "${mysql_app_args[@]}" -N -B -e "SELECT 1" >/dev/null 2>&1; then
    echo "Connected to MySQL as ${MRBS_DB_USER}."
    break
  fi

  if [ "${wait_for_root}" = "true" ] && mysql "${mysql_root_args[@]}" -N -B -e "SELECT 1" >/dev/null 2>&1; then
    echo "Connected to MySQL as root. Ensuring MRBS database and user exist..."
    db_escaped="\`$(printf "%s" "${MRBS_DB_DATABASE}" | sed 's/`/``/g')\`"
    user_escaped="$(sql_escape "${MRBS_DB_USER}")"
    pass_escaped="$(sql_escape "${MRBS_DB_PASSWORD}")"
    mysql "${mysql_root_args[@]}" <<SQL
CREATE DATABASE IF NOT EXISTS ${db_escaped} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${user_escaped}'@'%' IDENTIFIED WITH mysql_native_password BY '${pass_escaped}';
ALTER USER '${user_escaped}'@'%' IDENTIFIED WITH mysql_native_password BY '${pass_escaped}';
GRANT ALL PRIVILEGES ON ${db_escaped}.* TO '${user_escaped}'@'%';
FLUSH PRIVILEGES;
SQL
    if mysql "${mysql_app_args[@]}" -N -B -e "SELECT 1" >/dev/null 2>&1; then
      echo "Connected to MySQL as ${MRBS_DB_USER} after database/user check."
      break
    fi
  fi

  if [ "$i" -eq 90 ]; then
    echo "ERROR: Could not connect to MySQL after 180 seconds."
    echo "Check MRBS_DB_HOST, MRBS_DB_DATABASE, MRBS_DB_USER, MRBS_DB_PASSWORD, and MYSQL_ROOT_PASSWORD in Portainer."
    exit 1
  fi

  sleep 2
done

prefix="${MRBS_DB_TBL_PREFIX}"
required_table="${prefix}variables"

schema_exists=$(mysql "${mysql_app_args[@]}" -N -B -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${MRBS_DB_DATABASE}' AND table_name='${required_table}'" 2>/dev/null || echo "0")

if [ "${schema_exists}" != "1" ]; then
  echo "MRBS tables were not found. Creating schema..."
  mysql "${mysql_app_args[@]}" < /opt/mrbs/sql/tables.my.sql

  if [ -f /opt/mrbs/sql/fdny-room-seed.my.sql ]; then
    echo "Loading FDNY room seed data..."
    mysql "${mysql_app_args[@]}" < /opt/mrbs/sql/fdny-room-seed.my.sql || true
  fi

  if [ "${MRBS_LOAD_SAMPLE_BOOKINGS:-0}" = "1" ] && [ -f /opt/mrbs/sql/fdny-sample-bookings.my.sql ]; then
    echo "Loading sample bookings..."
    mysql "${mysql_app_args[@]}" < /opt/mrbs/sql/fdny-sample-bookings.my.sql || true
  fi
else
  echo "MRBS tables already exist. Skipping schema import."
fi

exec "$@"
