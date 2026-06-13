# MRBS Classroom Booking

Current Version: 1.4.3

## 1.4.3
- Improved Docker/MySQL startup reliability for Portainer.
- Added MySQL first-run init script to create the MRBS database and user from environment variables.
- Added clearer app-container log messages while waiting for MySQL.
- Removed hard compose interpolation failures by providing safe local defaults; production passwords should still be set in Portainer.

## 1.4.2
- Fixed Docker environment variable handling.
- Added database/user verification during startup.
- Added VERSION.md.

## 1.4.1
- Docker environment variable fix.

## 1.4.0
- Added Event Calendar report.
- Added Event booking flag.
- Added passed-event indicators.
