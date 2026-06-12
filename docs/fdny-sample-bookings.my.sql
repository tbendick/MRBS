-- Sample bookings imported from the weekly assignment spreadsheets.
-- Safe to rerun: matching room/start/name rows are not duplicated.

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Auditorium'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Auditorium'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Auditorium'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Auditorium'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Auditorium'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BC AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-BC AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Conference 30'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'BC AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 108/109'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 108/109'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 108/109'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 108/109'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 108/109'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 116'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 116'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 116'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 116'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'CTS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-CTS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 116'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'CTS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'OOS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-OOS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 117'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'OOS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'OOS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-OOS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 117'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'OOS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'OOS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-OOS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 117'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'OOS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'OOS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-OOS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 117'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'OOS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'OOS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-OOS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 117'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'OOS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'R', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-R')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'R');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'E', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-E')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'E');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'S', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-S')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'S');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'C', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-C')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'C');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'U', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-U')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'U');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-13 08:00:00'), UNIX_TIMESTAMP('2026-06-13 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'E', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-13-E')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 139'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-13 08:00:00') AND E.name = 'E');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BFI', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-BFI')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'BFI');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BFI', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-BFI')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'BFI');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BFI', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-BFI')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'BFI');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BFI', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-BFI')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'BFI');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BFI', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-BFI')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'BFI');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-13 08:00:00'), UNIX_TIMESTAMP('2026-06-13 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Air Entrainment', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-13-Air Entrainment')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 126'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-13 08:00:00') AND E.name = 'Air Entrainment');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 260'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 260'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 260'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 260'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 260'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 262'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 262'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FF For a Day NYCHA', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-FF For a Day NYCHA')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 262'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'FF For a Day NYCHA');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 262'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 262'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'NFA- OPD', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-NFA- OPD')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 264'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'NFA- OPD');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'NFA- OPD', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-NFA- OPD')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 264'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'NFA- OPD');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 264'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'NFA- OPD', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-NFA- OPD')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 266'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'NFA- OPD');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'NFA- OPD', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-NFA- OPD')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 266'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'NFA- OPD');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 266'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 268'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 268'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 268'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 268'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 268'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Chief Command', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Chief Command')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 270'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Chief Command');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Chief Command', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Chief Command')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 270'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Chief Command');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Chief Command', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-Chief Command')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 270'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'Chief Command');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Chief Command', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-Chief Command')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 270'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'Chief Command');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Chief Command', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-Chief Command')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 270'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'Chief Command');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'BC Aide AED', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-BC Aide AED')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Mand Library'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'BC Aide AED');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Mand Library'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 06:00:00'), UNIX_TIMESTAMP('2026-06-08 15:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Lunchroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 06:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Lunchroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Lunchroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Air Entrainment', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-Air Entrainment')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Lunchroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'Air Entrainment');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 360 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 360 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 360 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 360 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Room 360 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Capt. Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Capt. Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Classroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Capt. Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Capt. Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Capt. Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Classroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Capt. Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Capt. Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-Capt. Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Classroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'Capt. Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Capt. Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-Capt. Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Classroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'Capt. Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Capt. Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-Capt. Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Classroom'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'Capt. Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Leadership Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Leadership Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Lecture Hall'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Leadership Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Leadership Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Leadership Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Lecture Hall'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Leadership Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Leadership Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-Leadership Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Lecture Hall'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'Leadership Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Leadership Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-Leadership Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Lecture Hall'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'Leadership Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Leadership Development', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-Leadership Development')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = '4th fl. Lecture Hall'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'Leadership Development');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Radio Team', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Radio Team')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Rm 362'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Radio Team');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Radio Team', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Radio Team')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Rm 362'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Radio Team');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Radio Team', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-Radio Team')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Rm 362'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'Radio Team');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Radio Team', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-Radio Team')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Rm 362'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'Radio Team');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Radio Team', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-Radio Team')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Rm 362'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'Radio Team');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'ERP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-ERP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Classrooms' AND R.room_name = 'Trailer 17 M'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'ERP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-10 08:00:00'), UNIX_TIMESTAMP('2026-06-10 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-10-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '3-Taxpayer'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-10 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'FLSTP', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-FLSTP')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '3-Taxpayer'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'FLSTP');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Victim Removal', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Victim Removal')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '5-Fire Simulator'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Victim Removal');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Victim Removal', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Victim Removal')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '5-Fire Simulator'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Victim Removal');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-11 08:00:00'), UNIX_TIMESTAMP('2026-06-11 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-11-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '5-Fire Simulator'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-11 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-12 08:00:00'), UNIX_TIMESTAMP('2026-06-12 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'PFS', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-12-PFS')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '5-Fire Simulator'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-12 08:00:00') AND E.name = 'PFS');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-08 08:00:00'), UNIX_TIMESTAMP('2026-06-08 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Victim Removal', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-08-Victim Removal')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '12-207 Mask Search'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-08 08:00:00') AND E.name = 'Victim Removal');

INSERT INTO mrbs_entry (start_time, end_time, entry_type, room_id, create_by, modified_by, name, type, description, status, ical_uid)
SELECT UNIX_TIMESTAMP('2026-06-09 08:00:00'), UNIX_TIMESTAMP('2026-06-09 17:00:00'), 0, R.id, 'sample_import', 'sample_import', 'Victim Removal', 'E', 'Imported from weekly assignment spreadsheet', 0, CONCAT('sample-', R.id, '-2026-06-09-Victim Removal')
FROM mrbs_room R JOIN mrbs_area A ON A.id = R.area_id
WHERE A.area_name = 'Training Buildings' AND R.room_name = '12-207 Mask Search'
  AND NOT EXISTS (SELECT 1 FROM mrbs_entry E WHERE E.room_id = R.id AND E.start_time = UNIX_TIMESTAMP('2026-06-09 08:00:00') AND E.name = 'Victim Removal');
