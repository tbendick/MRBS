#!/usr/bin/env bash
set -euo pipefail

: "${MRBS_DB_HOST:?MRBS_DB_HOST is required}"
: "${MRBS_DB_DATABASE:?MRBS_DB_DATABASE is required}"
: "${MRBS_DB_USER:?MRBS_DB_USER is required}"
: "${MRBS_DB_PASSWORD:?MRBS_DB_PASSWORD is required}"
: "${MRBS_DB_TBL_PREFIX:=mrbs_}"

MYSQL_ARGS=(
  --protocol=TCP
  --host="${MRBS_DB_HOST}"
  --user="${MRBS_DB_USER}"
  --password="${MRBS_DB_PASSWORD}"
  "${MRBS_DB_DATABASE}"
)

prefix="${MRBS_DB_TBL_PREFIX}"
required_table="${prefix}variables"

echo "Waiting for MySQL at ${MRBS_DB_HOST}..."
until mysql "${MYSQL_ARGS[@]}" -N -B -e "SELECT 1" >/dev/null 2>&1; do
  sleep 2
done

schema_exists=$(mysql "${MYSQL_ARGS[@]}" -N -B -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${MRBS_DB_DATABASE}' AND table_name='${required_table}'" 2>/dev/null || echo "0")

if [ "${schema_exists}" != "1" ]; then
  echo "MRBS tables were not found. Creating schema..."
  mysql "${MYSQL_ARGS[@]}" < /opt/mrbs/sql/tables.my.sql

  if [ -f /opt/mrbs/sql/fdny-room-seed.my.sql ]; then
    echo "Loading FDNY room seed data..."
    mysql "${MYSQL_ARGS[@]}" < /opt/mrbs/sql/fdny-room-seed.my.sql || true
  fi

  if [ "${MRBS_LOAD_SAMPLE_BOOKINGS:-0}" = "1" ] && [ -f /opt/mrbs/sql/fdny-sample-bookings.my.sql ]; then
    echo "Loading sample bookings..."
    mysql "${MYSQL_ARGS[@]}" < /opt/mrbs/sql/fdny-sample-bookings.my.sql || true
  fi
else
  echo "MRBS tables already exist. Skipping schema import."
fi

exec "$@"
