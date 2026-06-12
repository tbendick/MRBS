<?php
declare(strict_types=1);
namespace MRBS;

require_once 'functions_mail.inc';

const EVENT_REQUEST_PENDING = 'pending';
const EVENT_REQUEST_ASSIGNED = 'assigned';
const EVENT_REQUEST_DENIED = 'denied';
const EVENT_REQUEST_CANCELLED = 'cancelled';


function event_request_field_table() : string
{
  return _tbl('event_request_field');
}

function event_request_field_value_table() : string
{
  return _tbl('event_request_field_value');
}

function ensure_event_request_field_schema() : void
{
  if (!db()->table_exists(event_request_field_table()))
  {
    $sql = "CREATE TABLE " . event_request_field_table() . "
    (
      id int NOT NULL auto_increment,
      field_key varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
      label varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
      field_type varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'text' NOT NULL,
      options text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
      help_text varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
      is_required tinyint DEFAULT 0 NOT NULL,
      is_enabled tinyint DEFAULT 1 NOT NULL,
      sort_order int DEFAULT 0 NOT NULL,
      created_at int NOT NULL COMMENT 'Unix timestamp',
      updated_at int NOT NULL COMMENT 'Unix timestamp',

      PRIMARY KEY (id),
      UNIQUE KEY uqEventRequestFieldKey (field_key),
      KEY idxEventRequestFieldEnabled (is_enabled, sort_order)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
    db()->command($sql);
  }

  if (!db()->table_exists(event_request_field_value_table()))
  {
    $sql = "CREATE TABLE " . event_request_field_value_table() . "
    (
      id int NOT NULL auto_increment,
      request_id int NOT NULL,
      field_id int NOT NULL,
      value text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,

      PRIMARY KEY (id),
      UNIQUE KEY uqEventRequestFieldValue (request_id, field_id),
      KEY idxEventRequestFieldValueRequest (request_id),
      KEY idxEventRequestFieldValueField (field_id),
      FOREIGN KEY (request_id)
        REFERENCES " . event_request_table() . "(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
      FOREIGN KEY (field_id)
        REFERENCES " . event_request_field_table() . "(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";
    db()->command($sql);
  }
}

function event_request_field_types() : array
{
  return [
    'text' => 'Short text',
    'textarea' => 'Long text',
    'select' => 'Dropdown',
    'checkbox' => 'Checkbox',
    'date' => 'Date',
    'number' => 'Number',
    'email' => 'Email'
  ];
}

function event_request_normalize_field_key(string $label, string $fallback='field') : string
{
  $key = strtolower(trim($label));
  $key = preg_replace('/[^a-z0-9]+/', '_', $key);
  $key = trim((string)$key, '_');
  return ($key === '') ? $fallback : substr($key, 0, 70);
}

function event_request_fields(bool $enabled_only=true) : array
{
  ensure_event_request_field_schema();
  $where = $enabled_only ? 'WHERE is_enabled = 1' : '';
  $sql = "SELECT * FROM " . event_request_field_table() . " $where ORDER BY sort_order, id";
  $res = db()->query($sql);
  $fields = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $row['id'] = (int)$row['id'];
    $row['is_required'] = (int)$row['is_required'];
    $row['is_enabled'] = (int)$row['is_enabled'];
    $row['sort_order'] = (int)$row['sort_order'];
    $fields[] = $row;
  }
  return $fields;
}

function event_request_custom_values(int $request_id) : array
{
  ensure_event_request_field_schema();
  $sql = "SELECT F.field_key, V.value
            FROM " . event_request_field_value_table() . " V
            JOIN " . event_request_field_table() . " F ON F.id = V.field_id
           WHERE V.request_id = :request_id";
  $res = db()->query($sql, [':request_id' => $request_id]);
  $values = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $values[$row['field_key']] = $row['value'] ?? '';
  }
  return $values;
}

function event_request_save_custom_values(int $request_id, array $fields, array $values) : void
{
  ensure_event_request_field_schema();
  foreach ($fields as $field)
  {
    $field_id = (int)$field['id'];
    $value = trim((string)($values[$field['field_key']] ?? ''));
    if ($field['field_type'] === 'checkbox')
    {
      $value = empty($values[$field['field_key']]) ? '0' : '1';
    }
    $sql = "INSERT INTO " . event_request_field_value_table() . "
                  (request_id, field_id, value)
            VALUES (:request_id, :field_id, :value)
            ON DUPLICATE KEY UPDATE value = :value_update";
    db()->command($sql, [
      ':request_id' => $request_id,
      ':field_id' => $field_id,
      ':value' => $value,
      ':value_update' => $value
    ]);
  }
}

function event_request_custom_text(int $request_id) : string
{
  $fields = event_request_fields(false);
  if (count($fields) === 0)
  {
    return '';
  }
  $values = event_request_custom_values($request_id);
  $lines = [];
  foreach ($fields as $field)
  {
    if (!isset($values[$field['field_key']]) || ($values[$field['field_key']] === ''))
    {
      continue;
    }
    $value = ($field['field_type'] === 'checkbox') ? (((string)$values[$field['field_key']] === '1') ? 'Yes' : 'No') : $values[$field['field_key']];
    $lines[] = $field['label'] . ': ' . $value;
  }
  return implode("\n", $lines);
}

function event_request_table() : string
{
  return _tbl('event_request');
}

function ensure_event_request_schema() : void
{
  if (db()->table_exists(event_request_table()))
  {
    ensure_event_request_columns();
    ensure_room_editor_schema();
    ensure_event_request_field_schema();
    return;
  }

  $sql = "CREATE TABLE " . event_request_table() . "
  (
    id int NOT NULL auto_increment,
    status varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'pending' NOT NULL,
    requester_name varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    requester_phone varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    requester_email varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    department varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    event_name varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    description text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    requested_start int NOT NULL COMMENT 'Unix timestamp',
    requested_end int NOT NULL COMMENT 'Unix timestamp',
    flexible_time tinyint DEFAULT 0 NOT NULL,
    quantity int DEFAULT 0 NOT NULL,
    tech_needs text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    setup_needs text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    catering_needs text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    accessibility_needs text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    notes text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    created_by_username varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    created_by_email varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    assigned_entry_id int DEFAULT NULL,
    denial_reason varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    denial_comment text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    decided_by_username varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    decided_at int DEFAULT NULL COMMENT 'Unix timestamp',
    admin_note text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    created_at int NOT NULL COMMENT 'Unix timestamp',
    updated_at int NOT NULL COMMENT 'Unix timestamp',

    PRIMARY KEY (id),
    FOREIGN KEY (assigned_entry_id)
      REFERENCES " . _tbl('entry') . "(id)
      ON UPDATE CASCADE
      ON DELETE SET NULL,
    KEY idxEventRequestStatus (status),
    KEY idxEventRequestEmail (requester_email),
    KEY idxEventRequestCreatedBy (created_by_username),
    KEY idxEventRequestStart (requested_start)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

  db()->command($sql);
  ensure_room_editor_schema();
  ensure_event_request_field_schema();
}

function ensure_event_request_columns() : void
{
  $fields = db()->field_info(event_request_table());
  $field_names = array_column($fields, 'name');
  $columns = [
    'denial_reason' => "ALTER TABLE " . event_request_table() . " ADD COLUMN denial_reason varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL",
    'denial_comment' => "ALTER TABLE " . event_request_table() . " ADD COLUMN denial_comment text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL",
    'decided_by_username' => "ALTER TABLE " . event_request_table() . " ADD COLUMN decided_by_username varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL",
    'decided_at' => "ALTER TABLE " . event_request_table() . " ADD COLUMN decided_at int DEFAULT NULL COMMENT 'Unix timestamp'"
  ];

  foreach ($columns as $name => $sql)
  {
    if (!in_array($name, $field_names))
    {
      db()->command($sql);
    }
  }
}

function room_editor_table() : string
{
  return _tbl('room_editor');
}

function ensure_room_editor_schema() : void
{
  if (db()->table_exists(room_editor_table()))
  {
    return;
  }

  $sql = "CREATE TABLE " . room_editor_table() . "
  (
    id int NOT NULL auto_increment,
    username varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    room_id int DEFAULT 0 NOT NULL COMMENT '0 means all rooms',
    created_by varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    created_at int NOT NULL COMMENT 'Unix timestamp',

    PRIMARY KEY (id),
    UNIQUE KEY uqRoomEditor (username, room_id),
    KEY idxRoomEditorUsername (username),
    KEY idxRoomEditorRoom (room_id)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4";

  db()->command($sql);
}

function user_is_room_editor(?User $user, $rooms=null, bool $all=true) : bool
{
  if (!isset($user))
  {
    return false;
  }

  ensure_room_editor_schema();

  if (is_null($rooms))
  {
    $sql = "SELECT COUNT(*)
              FROM " . room_editor_table() . "
             WHERE username = :username
               AND room_id = 0";
    return (db()->query1($sql, [':username' => $user->username]) > 0);
  }

  $room_list = is_array($rooms) ? $rooms : [$rooms];
  if (count($room_list) === 0)
  {
    return false;
  }

  $matches = 0;
  foreach ($room_list as $room_id)
  {
    $sql = "SELECT COUNT(*)
              FROM " . room_editor_table() . "
             WHERE username = :username
               AND (room_id = 0 OR room_id = :room_id)";
    if (db()->query1($sql, [':username' => $user->username, ':room_id' => (int)$room_id]) > 0)
    {
      $matches++;
    }
  }

  return $all ? ($matches === count($room_list)) : ($matches > 0);
}

function current_user_is_request_manager() : bool
{
  $user = session()->getCurrentUser();
  if (is_admin())
  {
    return true;
  }

  if (!isset($user))
  {
    return false;
  }

  ensure_room_editor_schema();
  $sql = "SELECT COUNT(*)
            FROM " . room_editor_table() . "
           WHERE username = :username";

  return (db()->query1($sql, [':username' => $user->username]) > 0);
}

function current_user_editable_room_ids() : array
{
  $user = session()->getCurrentUser();
  if (!isset($user))
  {
    return [];
  }

  if (is_admin())
  {
    $sql = "SELECT id FROM " . _tbl('room') . " WHERE disabled = 0 ORDER BY sort_key, room_name";
    return array_map('intval', db()->query_array($sql));
  }

  if (!user_is_room_editor($user))
  {
    return [];
  }

  $sql = "SELECT COUNT(*)
            FROM " . room_editor_table() . "
           WHERE username = :username
             AND room_id = 0";
  if (db()->query1($sql, [':username' => $user->username]) > 0)
  {
    $sql = "SELECT id FROM " . _tbl('room') . " WHERE disabled = 0 ORDER BY sort_key, room_name";
    return array_map('intval', db()->query_array($sql));
  }

  $sql = "SELECT R.id
            FROM " . room_editor_table() . " E
            JOIN " . _tbl('room') . " R ON R.id = E.room_id
           WHERE E.username = :username
             AND R.disabled = 0
        ORDER BY R.sort_key, R.room_name";
  return array_map('intval', db()->query_array($sql, [':username' => $user->username]));
}

function current_user_editable_rooms() : array
{
  $ids = current_user_editable_room_ids();
  if (count($ids) === 0)
  {
    return [];
  }

  $params = [];
  $placeholders = [];
  foreach ($ids as $index => $id)
  {
    $key = ":room_$index";
    $placeholders[] = $key;
    $params[$key] = $id;
  }

  $sql = "SELECT R.id, R.room_name, A.area_name
            FROM " . _tbl('room') . " R
            JOIN " . _tbl('area') . " A ON A.id = R.area_id
           WHERE R.id IN (" . implode(',', $placeholders) . ")
        ORDER BY A.sort_key, A.area_name, R.sort_key, R.room_name";
  $res = db()->query($sql, $params);
  $rooms = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $row['id'] = (int)$row['id'];
    $rooms[] = $row;
  }

  return $rooms;
}

function event_request_user_email(?User $user) : ?string
{
  if (!isset($user) || empty($user->email))
  {
    return null;
  }

  return mb_strtolower(trim($user->email));
}

function event_request_fetch(int $id) : ?array
{
  $sql = "SELECT *
            FROM " . event_request_table() . "
           WHERE id = :id
           LIMIT 1";
  $res = db()->query($sql, [':id' => $id]);
  $row = $res->next_row_keyed();

  return ($row === false) ? null : $row;
}

function event_request_can_edit(array $row, ?User $user) : bool
{
  if (!isset($user))
  {
    return false;
  }

  if (function_exists(__NAMESPACE__ . '\is_admin') && is_admin())
  {
    return true;
  }

  if (!empty($row['created_by_username']) && (compare_usernames($row['created_by_username'], $user->username) === 0))
  {
    return true;
  }

  $user_email = event_request_user_email($user);
  if (isset($user_email) && (mb_strtolower($row['requester_email']) === $user_email))
  {
    return true;
  }

  return false;
}

function event_request_user_filter(?User $user) : array
{
  if (!isset($user))
  {
    return ['1=0', []];
  }

  if (function_exists(__NAMESPACE__ . '\is_admin') && is_admin())
  {
    return ['1=1', []];
  }

  $clauses = ['created_by_username = :username'];
  $params = [':username' => $user->username];
  $email = event_request_user_email($user);

  if (isset($email))
  {
    $clauses[] = 'LOWER(requester_email) = :email';
    $params[':email'] = $email;
  }

  return ['(' . implode(' OR ', $clauses) . ')', $params];
}

function event_request_status_label(string $status) : string
{
  switch ($status)
  {
    case EVENT_REQUEST_ASSIGNED:
      return 'Assigned';
    case EVENT_REQUEST_DENIED:
      return 'Denied';
    case EVENT_REQUEST_CANCELLED:
      return 'Cancelled';
    case EVENT_REQUEST_PENDING:
    default:
      return 'Pending';
  }
}

function event_request_send_notice(array $request, string $action) : void
{
  global $mail_settings, $mrbs_admin_email, $mrbs_company;

  if (!validate_email($request['requester_email']))
  {
    return;
  }

  $from = $mail_settings['from'] ?? $mrbs_admin_email;
  $admin_to = $mail_settings['recipients'] ?? $mrbs_admin_email;
  $subject_action = ($action === 'updated') ? 'Updated' : 'Received';
  $subject = "$mrbs_company event request $subject_action: " . $request['event_name'];

  $body = "Event request $subject_action\n\n" .
          "Request ID: " . $request['id'] . "\n" .
          "Status: " . event_request_status_label($request['status']) . "\n" .
          "Event: " . $request['event_name'] . "\n" .
          "Requester: " . $request['requester_name'] . "\n" .
          "Email: " . $request['requester_email'] . "\n" .
          "Phone: " . ($request['requester_phone'] ?? '') . "\n" .
          "Department: " . ($request['department'] ?? '') . "\n" .
          "When: " . time_date_string((int)$request['requested_start']) . " to " .
          time_date_string((int)$request['requested_end']) . "\n" .
          "People: " . (int)$request['quantity'] . "\n\n" .
          "Description:\n" . ($request['description'] ?? '') . "\n\n" .
          "Tech needs:\n" . ($request['tech_needs'] ?? '') . "\n\n" .
          "Setup needs:\n" . ($request['setup_needs'] ?? '') . "\n\n" .
          "Catering needs:\n" . ($request['catering_needs'] ?? '') . "\n\n" .
          "Accessibility needs:\n" . ($request['accessibility_needs'] ?? '') . "\n\n" .
          ((isset($request['id']) && (event_request_custom_text((int)$request['id']) !== '')) ? "Additional fields:\n" . event_request_custom_text((int)$request['id']) . "\n\n" : '') .
          "Other notes:\n" . ($request['notes'] ?? '') . "\n";

  $addresses = [
    'from' => $from,
    'to' => $request['requester_email'],
    'cc' => $admin_to
  ];

  MailQueue::add($addresses, $subject, $body, null, null, Language::MAIL_CHARSET);
}
