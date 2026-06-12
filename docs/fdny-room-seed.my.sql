-- FDNY training room/building seed data.
-- Safe to rerun: areas and rooms are inserted only when missing.

INSERT INTO mrbs_area (area_name, sort_key)
SELECT 'Classrooms', 'Classrooms'
WHERE NOT EXISTS (
  SELECT 1 FROM mrbs_area WHERE area_name = 'Classrooms'
);

INSERT INTO mrbs_area (area_name, sort_key)
SELECT 'Training Buildings', 'Training Buildings'
WHERE NOT EXISTS (
  SELECT 1 FROM mrbs_area WHERE area_name = 'Training Buildings'
);

INSERT INTO mrbs_room (disabled, area_id, room_name, sort_key, description, capacity, custom_html)
SELECT 0, A.id, rooms.room_name, rooms.room_name, rooms.description, rooms.capacity, rooms.custom_html
FROM mrbs_area A
JOIN (
  SELECT 'Auditorium' AS room_name, 'A/V: P' AS description, 450 AS capacity, NULL AS custom_html UNION ALL
  SELECT 'Conference 30', 'Imported from weekly classroom assignments', 30, NULL UNION ALL
  SELECT 'Room 108/109', 'A/V: P; listed size 30/40', 40, NULL UNION ALL
  SELECT 'Room 116', 'A/V: Vid Conf', 30, NULL UNION ALL
  SELECT 'Room 117', 'A/V: M', 20, NULL UNION ALL
  SELECT 'Room 139', 'A/V: M', 50, NULL UNION ALL
  SELECT 'Room 126', 'A/V: M', 84, NULL UNION ALL
  SELECT 'Room 260', 'Imported from weekly classroom assignments', 0, NULL UNION ALL
  SELECT 'Room 262', 'A/V: M', 35, NULL UNION ALL
  SELECT 'Room 264', 'A/V: M', 35, NULL UNION ALL
  SELECT 'Room 266', 'A/V: M', 35, NULL UNION ALL
  SELECT 'Room 268', 'A/V: M', 35, NULL UNION ALL
  SELECT 'Room 270', 'A/V: P', 35, NULL UNION ALL
  SELECT 'Mand Library', 'A/V: M', 25, NULL UNION ALL
  SELECT 'Lunchroom', 'Bldg. 11; A/V: P', 0, NULL UNION ALL
  SELECT 'Room 360', 'A/V: M', 0, NULL UNION ALL
  SELECT '4th fl. Classroom', 'Imported from weekly classroom assignments', 20, NULL UNION ALL
  SELECT '4th fl. Lecture Hall', 'A/V: P', 50, NULL UNION ALL
  SELECT 'Rm 362', 'A/V: M', 30, NULL UNION ALL
  SELECT 'Trailer 16', 'A/V: M', 0, NULL UNION ALL
  SELECT 'Trailer 17', 'A/V: M', 0, NULL UNION ALL
  SELECT 'Trailer 19', 'Imported from weekly classroom assignments', 0, NULL
) AS rooms
WHERE A.area_name = 'Classrooms'
  AND NOT EXISTS (
    SELECT 1
    FROM mrbs_room R
    WHERE R.area_id = A.id
      AND R.room_name = rooms.room_name
  );

INSERT INTO mrbs_room (disabled, area_id, room_name, sort_key, description, capacity, custom_html)
SELECT 0, A.id, room_name, room_name, description, 0, NULL
FROM mrbs_area A
JOIN (
  SELECT '1-High Rise' AS room_name, 'Imported from weekly building assignments' AS description UNION ALL
  SELECT '2-Smoke House', 'Imported from weekly building assignments' UNION ALL
  SELECT '3-Taxpayer', 'Imported from weekly building assignments' UNION ALL
  SELECT '4-OLT', 'Imported from weekly building assignments' UNION ALL
  SELECT '5-Fire Simulator', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-203 Mask Confidence', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-207 Mask Search', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-211 Mask Search', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-200 Mask Obstacle', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-202 Field House', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-1st fl.', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-206', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-208 FF Removal', 'Imported from weekly building assignments' UNION ALL
  SELECT '12-210 FF Removal', 'Imported from weekly building assignments' UNION ALL
  SELECT '14-Subway Tunnel', 'Imported from weekly building assignments' UNION ALL
  SELECT '14-Extrication Area', 'Imported from weekly building assignments' UNION ALL
  SELECT 'Marine Simulator', 'Imported from weekly building assignments'
) AS rooms
WHERE A.area_name = 'Training Buildings'
  AND NOT EXISTS (
    SELECT 1
    FROM mrbs_room R
    WHERE R.area_id = A.id
      AND R.room_name = rooms.room_name
  );
