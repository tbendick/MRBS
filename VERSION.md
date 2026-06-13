# MRBS Classroom Booking

Current Version: 1.4.4

## 1.4.4
- Changed Docker MySQL volume to `mrbs_mysql_data_v144` to avoid stale initialized volumes during testing.
- Added `MYSQL_ROOT_HOST=%` so the app container can perform first-start database/user repair when needed.
- Added clearer root-login diagnostics to the app startup script.

## 1.4.3
- Added MySQL init script and improved app startup logging.

## 1.4.2
- Improved Docker database bootstrap and environment variable handling.
