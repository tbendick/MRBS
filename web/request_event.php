<?php
declare(strict_types=1);
namespace MRBS;

use MRBS\Form\Form;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
ensure_event_request_schema();
$custom_fields = event_request_fields(true);
$custom_values = [];

$mrbs_user = session()->getCurrentUser();
$id = get_form_var('id', 'int');
$saved = false;
$errors = [];

$blank = [
  'id' => null,
  'status' => EVENT_REQUEST_PENDING,
  'requester_name' => $mrbs_user->display_name ?? '',
  'requester_phone' => '',
  'requester_email' => $mrbs_user->email ?? '',
  'department' => '',
  'event_name' => '',
  'description' => '',
  'requested_date' => date('Y-m-d'),
  'start_time' => '09:00',
  'end_time' => '10:00',
  'flexible_time' => 0,
  'quantity' => 0,
  'tech_needs' => '',
  'setup_needs' => '',
  'catering_needs' => '',
  'accessibility_needs' => '',
  'notes' => ''
];

$request = $blank;

if (isset($id))
{
  $existing = event_request_fetch($id);
  if (!isset($existing) || !event_request_can_edit($existing, $mrbs_user))
  {
    showAccessDenied($view, $view_all, $year, $month, $day, $area ?? null, isset($room) ? $room : null);
    exit;
  }

  $request = $existing + $request;
  $request['requested_date'] = date('Y-m-d', (int)$existing['requested_start']);
  $request['start_time'] = date('H:i', (int)$existing['requested_start']);
  $request['end_time'] = date('H:i', (int)$existing['requested_end']);
  $custom_values = event_request_custom_values((int)$existing['id']);
}

foreach ($custom_fields as $custom_field)
{
  $custom_values[$custom_field['field_key']] = $custom_values[$custom_field['field_key']] ?? '';
}

if (($server['REQUEST_METHOD'] ?? '') === 'POST')
{
  Form::checkToken();

  $id = get_form_var('id', 'int', null, INPUT_POST);
  if (isset($id))
  {
    $existing = event_request_fetch($id);
    if (!isset($existing) || !event_request_can_edit($existing, $mrbs_user))
    {
      showAccessDenied($view, $view_all, $year, $month, $day, $area ?? null, isset($room) ? $room : null);
      exit;
    }
  }

  foreach (['requester_name', 'requester_phone', 'requester_email', 'department', 'event_name',
            'description', 'requested_date', 'start_time', 'end_time', 'tech_needs',
            'setup_needs', 'catering_needs', 'accessibility_needs', 'notes'] as $field)
  {
    $request[$field] = trim((string)get_form_var($field, 'string', '', INPUT_POST));
  }
  $request['quantity'] = max(0, (int)get_form_var('quantity', 'int', 0, INPUT_POST));
  $request['flexible_time'] = get_form_var('flexible_time', 'bool', false, INPUT_POST) ? 1 : 0;

  $posted_custom = $_POST['custom_fields'] ?? [];
  if (!is_array($posted_custom))
  {
    $posted_custom = [];
  }
  foreach ($custom_fields as $custom_field)
  {
    $key = $custom_field['field_key'];
    $custom_values[$key] = ($custom_field['field_type'] === 'checkbox')
      ? (!empty($posted_custom[$key]) ? '1' : '0')
      : trim((string)($posted_custom[$key] ?? ''));
  }

  if ($request['requester_name'] === '')
  {
    $errors[] = 'Requester name is required.';
  }
  if (!validate_email($request['requester_email']))
  {
    $errors[] = 'A valid requester email is required.';
  }
  if ($request['event_name'] === '')
  {
    $errors[] = 'Event name is required.';
  }
  if ($request['description'] === '')
  {
    $errors[] = 'Description is required.';
  }
  if ($request['quantity'] < 1)
  {
    $errors[] = 'Quantity of people must be at least 1.';
  }

  foreach ($custom_fields as $custom_field)
  {
    if (!empty($custom_field['is_required']))
    {
      $custom_value = trim((string)($custom_values[$custom_field['field_key']] ?? ''));
      if (($custom_value === '') || (($custom_field['field_type'] === 'checkbox') && ($custom_value !== '1')))
      {
        $errors[] = $custom_field['label'] . ' is required.';
      }
    }
  }

  $requested_start = strtotime($request['requested_date'] . ' ' . $request['start_time']);
  $requested_end = strtotime($request['requested_date'] . ' ' . $request['end_time']);

  if (($requested_start === false) || ($requested_end === false))
  {
    $errors[] = 'Please enter a valid date and time.';
  }
  elseif ($requested_end <= $requested_start)
  {
    $errors[] = 'End time must be after start time.';
  }

  if (count($errors) === 0)
  {
    $now = time();
    $request['requester_email'] = mb_strtolower($request['requester_email']);
    $params = [
      ':status' => EVENT_REQUEST_PENDING,
      ':requester_name' => $request['requester_name'],
      ':requester_phone' => $request['requester_phone'],
      ':requester_email' => $request['requester_email'],
      ':department' => $request['department'],
      ':event_name' => $request['event_name'],
      ':description' => $request['description'],
      ':requested_start' => $requested_start,
      ':requested_end' => $requested_end,
      ':flexible_time' => $request['flexible_time'],
      ':quantity' => $request['quantity'],
      ':tech_needs' => $request['tech_needs'],
      ':setup_needs' => $request['setup_needs'],
      ':catering_needs' => $request['catering_needs'],
      ':accessibility_needs' => $request['accessibility_needs'],
      ':notes' => $request['notes'],
      ':updated_at' => $now
    ];

    if (isset($id))
    {
      $params[':id'] = $id;
      $sql = "UPDATE " . event_request_table() . "
                 SET status = :status,
                     requester_name = :requester_name,
                     requester_phone = :requester_phone,
                     requester_email = :requester_email,
                     department = :department,
                     event_name = :event_name,
                     description = :description,
                     requested_start = :requested_start,
                     requested_end = :requested_end,
                     flexible_time = :flexible_time,
                     quantity = :quantity,
                     tech_needs = :tech_needs,
                     setup_needs = :setup_needs,
                     catering_needs = :catering_needs,
                     accessibility_needs = :accessibility_needs,
                     notes = :notes,
                     updated_at = :updated_at
               WHERE id = :id";
      db()->command($sql, $params);
      $request['id'] = $id;
      $saved_action = 'updated';
    }
    else
    {
      $params[':created_by_username'] = $mrbs_user->username;
      $params[':created_by_email'] = $mrbs_user->email ?? null;
      $params[':created_at'] = $now;
      $sql = "INSERT INTO " . event_request_table() . "
                    (status, requester_name, requester_phone, requester_email, department,
                     event_name, description, requested_start, requested_end, flexible_time,
                     quantity, tech_needs, setup_needs, catering_needs, accessibility_needs,
                     notes, created_by_username, created_by_email, created_at, updated_at)
              VALUES (:status, :requester_name, :requester_phone, :requester_email, :department,
                      :event_name, :description, :requested_start, :requested_end, :flexible_time,
                      :quantity, :tech_needs, :setup_needs, :catering_needs, :accessibility_needs,
                      :notes, :created_by_username, :created_by_email, :created_at, :updated_at)";
      db()->command($sql, $params);
      $request['id'] = db()->insert_id(event_request_table(), 'id');
      $saved_action = 'created';
    }

    $request['status'] = EVENT_REQUEST_PENDING;
    $request['requested_start'] = $requested_start;
    $request['requested_end'] = $requested_end;
    event_request_save_custom_values((int)$request['id'], $custom_fields, $custom_values);
    event_request_send_notice($request, $saved_action);
    location_header(multisite('my_events.php?saved=1'));
    exit;
  }
}

print_header();
?>

<style>
.request_shell {
  max-width: 900px;
  margin: 0 auto;
  padding: 1rem;
}

.request_grid {
  display: grid;
  grid-template-columns: repeat(2, minmax(0, 1fr));
  gap: 1rem;
}

.request_field {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.request_field.full {
  grid-column: 1 / -1;
}

.request_field input,
.request_field textarea,
.request_field select {
  box-sizing: border-box;
  width: 100%;
}

.request_field textarea {
  min-height: 6rem;
}

.request_errors {
  border: 1px solid #b91c1c;
  border-radius: 8px;
  padding: 0.8rem 1rem;
  background: #fef2f2;
  color: #7f1d1d;
}

.request_actions {
  display: flex;
  gap: 0.75rem;
  align-items: center;
  margin-top: 1.2rem;
}

@media (max-width: 680px) {
  .request_grid {
    grid-template-columns: 1fr;
  }
}
</style>

<main class="request_shell">
  <h1><?php echo isset($request['id']) ? 'Update Event Request' : 'Request Event'; ?></h1>

  <?php if (count($errors) > 0): ?>
    <div class="request_errors">
      <?php foreach ($errors as $error): ?>
        <p><?php echo escape_html($error); ?></p>
      <?php endforeach; ?>
    </div>
  <?php endif; ?>

  <form method="post" action="<?php echo escape_html(multisite('request_event.php')); ?>">
    <?php echo Form::getTokenHTML(); ?>
    <?php if (isset($request['id'])): ?>
      <input type="hidden" name="id" value="<?php echo (int)$request['id']; ?>">
    <?php endif; ?>

    <div class="request_grid">
      <label class="request_field">
        <span>Name of requester</span>
        <input name="requester_name" value="<?php echo escape_html($request['requester_name']); ?>" required>
      </label>
      <label class="request_field">
        <span>Phone</span>
        <input name="requester_phone" value="<?php echo escape_html($request['requester_phone']); ?>">
      </label>
      <label class="request_field">
        <span>Email</span>
        <input type="email" name="requester_email" value="<?php echo escape_html($request['requester_email']); ?>" required>
      </label>
      <label class="request_field">
        <span>Department</span>
        <input name="department" value="<?php echo escape_html($request['department']); ?>">
      </label>
      <label class="request_field full">
        <span>Event name</span>
        <input name="event_name" value="<?php echo escape_html($request['event_name']); ?>" required>
      </label>
      <label class="request_field">
        <span>Date</span>
        <input type="date" name="requested_date" value="<?php echo escape_html($request['requested_date']); ?>" required>
      </label>
      <label class="request_field">
        <span>Quantity of people</span>
        <input type="number" name="quantity" min="1" value="<?php echo (int)$request['quantity']; ?>" required>
      </label>
      <label class="request_field">
        <span>Start time</span>
        <input type="time" name="start_time" value="<?php echo escape_html($request['start_time']); ?>" required>
      </label>
      <label class="request_field">
        <span>End time</span>
        <input type="time" name="end_time" value="<?php echo escape_html($request['end_time']); ?>" required>
      </label>
      <label class="request_field full">
        <span><input type="checkbox" name="flexible_time" value="1" <?php echo !empty($request['flexible_time']) ? 'checked' : ''; ?>> Time is flexible</span>
      </label>
      <label class="request_field full">
        <span>Description</span>
        <textarea name="description" required><?php echo escape_html($request['description']); ?></textarea>
      </label>
      <label class="request_field full">
        <span>Tech needs</span>
        <textarea name="tech_needs"><?php echo escape_html($request['tech_needs']); ?></textarea>
      </label>
      <label class="request_field full">
        <span>Setup needs</span>
        <textarea name="setup_needs"><?php echo escape_html($request['setup_needs']); ?></textarea>
      </label>
      <label class="request_field full">
        <span>Catering needs</span>
        <textarea name="catering_needs"><?php echo escape_html($request['catering_needs']); ?></textarea>
      </label>
      <label class="request_field full">
        <span>Accessibility needs</span>
        <textarea name="accessibility_needs"><?php echo escape_html($request['accessibility_needs']); ?></textarea>
      </label>
      <label class="request_field full">
        <span>Anything else</span>
        <textarea name="notes"><?php echo escape_html($request['notes']); ?></textarea>
      </label>

      <?php foreach ($custom_fields as $custom_field): ?>
        <?php
          $key = $custom_field['field_key'];
          $name = 'custom_fields[' . $key . ']';
          $value = $custom_values[$key] ?? '';
          $required = !empty($custom_field['is_required']) ? 'required' : '';
          $full = in_array($custom_field['field_type'], ['textarea'], true) ? ' full' : '';
          $options = preg_split('/\r\n|\r|\n/', (string)($custom_field['options'] ?? ''), -1, PREG_SPLIT_NO_EMPTY);
        ?>
        <label class="request_field<?php echo $full; ?>">
          <span><?php echo escape_html($custom_field['label']); ?><?php echo !empty($custom_field['is_required']) ? ' *' : ''; ?></span>
          <?php if ($custom_field['field_type'] === 'textarea'): ?>
            <textarea name="<?php echo escape_html($name); ?>" <?php echo $required; ?>><?php echo escape_html($value); ?></textarea>
          <?php elseif ($custom_field['field_type'] === 'select'): ?>
            <select name="<?php echo escape_html($name); ?>" <?php echo $required; ?>>
              <option value="">Select</option>
              <?php foreach ($options as $option): ?>
                <option value="<?php echo escape_html($option); ?>" <?php echo ($value === $option) ? 'selected' : ''; ?>><?php echo escape_html($option); ?></option>
              <?php endforeach; ?>
            </select>
          <?php elseif ($custom_field['field_type'] === 'checkbox'): ?>
            <span><input type="checkbox" name="<?php echo escape_html($name); ?>" value="1" <?php echo ((string)$value === '1') ? 'checked' : ''; ?>> Yes</span>
          <?php else: ?>
            <input type="<?php echo escape_html(in_array($custom_field['field_type'], ['date', 'number', 'email'], true) ? $custom_field['field_type'] : 'text'); ?>" name="<?php echo escape_html($name); ?>" value="<?php echo escape_html($value); ?>" <?php echo $required; ?>>
          <?php endif; ?>
          <?php if (!empty($custom_field['help_text'])): ?>
            <small><?php echo escape_html($custom_field['help_text']); ?></small>
          <?php endif; ?>
        </label>
      <?php endforeach; ?>
    </div>

    <div class="request_actions">
      <input type="submit" value="<?php echo isset($request['id']) ? 'Update Request' : 'Submit Request'; ?>">
      <a href="<?php echo escape_html(multisite('my_events.php')); ?>">My events</a>
    </div>
  </form>
</main>

<?php
print_footer();
