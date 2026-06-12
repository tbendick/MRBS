<?php
declare(strict_types=1);
namespace MRBS;

use MRBS\Form\Form;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
ensure_event_request_schema();

if (!current_user_is_request_manager())
{
  showAccessDenied($view, $view_all, $year, $month, $day, $area ?? null, isset($room) ? $room : null);
  exit;
}

$mrbs_user = session()->getCurrentUser();
$message = null;
$errors = [];

function pending_request_can_use_room(int $room_id) : bool
{
  return is_admin() || user_is_room_editor(session()->getCurrentUser(), $room_id);
}

function pending_request_create_booking(array $request, int $room_id) : int
{
  $custom_text = event_request_custom_text((int)$request['id']);
  $sql = "INSERT INTO " . _tbl('entry') . "
                (start_time, end_time, entry_type, room_id, create_by, modified_by,
                 name, type, description, status, ical_uid)
          VALUES (:start_time, :end_time, 0, :room_id, :create_by, :modified_by,
                  :name, 'E', :description, 0, :ical_uid)";
  db()->command($sql, [
    ':start_time' => (int)$request['requested_start'],
    ':end_time' => (int)$request['requested_end'],
    ':room_id' => $room_id,
    ':create_by' => $request['created_by_username'] ?: $request['requester_email'],
    ':modified_by' => session()->getCurrentUser()->username,
    ':name' => $request['event_name'],
    ':description' => trim(
      "Requester: " . $request['requester_name'] . "\n" .
      "Email: " . $request['requester_email'] . "\n" .
      "Phone: " . ($request['requester_phone'] ?? '') . "\n" .
      "Department: " . ($request['department'] ?? '') . "\n" .
      "People: " . (int)$request['quantity'] . "\n\n" .
      "Description:\n" . ($request['description'] ?? '') . "\n\n" .
      "Tech needs:\n" . ($request['tech_needs'] ?? '') . "\n\n" .
      "Setup needs:\n" . ($request['setup_needs'] ?? '') . "\n\n" .
      "Catering needs:\n" . ($request['catering_needs'] ?? '') . "\n\n" .
      "Accessibility needs:\n" . ($request['accessibility_needs'] ?? '') . "\n\n" .
      (($custom_text !== '') ? "Additional fields:\n" . $custom_text . "\n\n" : '') .
      "Notes:\n" . ($request['notes'] ?? '')
    ),
    ':ical_uid' => 'request-' . (int)$request['id'] . '-' . uniqid()
  ]);

  return db()->insert_id(_tbl('entry'), 'id');
}

if (($server['REQUEST_METHOD'] ?? '') === 'POST')
{
  Form::checkToken();
  $action = get_form_var('action', 'string', '', INPUT_POST);
  $request_id = get_form_var('request_id', 'int', null, INPUT_POST);
  $request = isset($request_id) ? event_request_fetch($request_id) : null;

  if (!isset($request))
  {
    $errors[] = 'Request not found.';
  }
  elseif ($action === 'assign')
  {
    $room_id = get_form_var('room_id', 'int', 0, INPUT_POST);
    $admin_note = trim((string)get_form_var('admin_note', 'string', '', INPUT_POST));
    if (!pending_request_can_use_room((int)$room_id))
    {
      $errors[] = 'You cannot assign requests to that room.';
    }
    else
    {
      $entry_id = pending_request_create_booking($request, (int)$room_id);
      $sql = "UPDATE " . event_request_table() . "
                 SET status = :status,
                     assigned_entry_id = :entry_id,
                     admin_note = :admin_note,
                     decided_by_username = :decided_by,
                     decided_at = :decided_at,
                     updated_at = :updated_at
               WHERE id = :id";
      db()->command($sql, [
        ':status' => EVENT_REQUEST_ASSIGNED,
        ':entry_id' => $entry_id,
        ':admin_note' => $admin_note,
        ':decided_by' => $mrbs_user->username,
        ':decided_at' => time(),
        ':updated_at' => time(),
        ':id' => (int)$request_id
      ]);
      $message = 'Request assigned and approved.';
    }
  }
  elseif ($action === 'deny')
  {
    $reason = trim((string)get_form_var('denial_reason', 'string', '', INPUT_POST));
    $comment = trim((string)get_form_var('denial_comment', 'string', '', INPUT_POST));
    if ($reason === '')
    {
      $errors[] = 'A denial reason is required.';
    }
    else
    {
      $sql = "UPDATE " . event_request_table() . "
                 SET status = :status,
                     denial_reason = :reason,
                     denial_comment = :comment,
                     decided_by_username = :decided_by,
                     decided_at = :decided_at,
                     updated_at = :updated_at
               WHERE id = :id";
      db()->command($sql, [
        ':status' => EVENT_REQUEST_DENIED,
        ':reason' => $reason,
        ':comment' => $comment,
        ':decided_by' => $mrbs_user->username,
        ':decided_at' => time(),
        ':updated_at' => time(),
        ':id' => (int)$request_id
      ]);
      $message = 'Request denied.';
    }
  }
}

$editable_rooms = current_user_editable_rooms();
$sql = "SELECT *
          FROM " . event_request_table() . "
         WHERE status = :status
      ORDER BY requested_start, id";
$res = db()->query($sql, [':status' => EVENT_REQUEST_PENDING]);
$requests = [];
while (false !== ($row = $res->next_row_keyed()))
{
  $requests[] = $row;
}

print_header();
?>

<main class="contents">
  <h1>Pending Event Requests</h1>
  <?php if (isset($message)): ?>
    <p><?php echo escape_html($message); ?></p>
  <?php endif; ?>
  <?php foreach ($errors as $error): ?>
    <p><?php echo escape_html($error); ?></p>
  <?php endforeach; ?>

  <?php if (count($requests) === 0): ?>
    <p>No pending event requests.</p>
  <?php else: ?>
    <?php foreach ($requests as $request): ?>
      <section>
        <h2><?php echo escape_html($request['event_name']); ?></h2>
        <p>
          <?php echo escape_html(time_date_string((int)$request['requested_start'])); ?>
          to
          <?php echo escape_html(time_date_string((int)$request['requested_end'])); ?>
        </p>
        <p>
          <?php echo escape_html($request['requester_name']); ?>,
          <?php echo escape_html($request['requester_email']); ?>,
          <?php echo (int)$request['quantity']; ?> people
        </p>
        <p><?php echo nl2br(escape_html($request['description'] ?? '')); ?></p>
        <?php $custom_text = event_request_custom_text((int)$request['id']); ?>
        <?php if ($custom_text !== ''): ?>
          <p><strong>Additional fields</strong><br><?php echo nl2br(escape_html($custom_text)); ?></p>
        <?php endif; ?>

        <form method="post" action="<?php echo escape_html(multisite('pending_requests.php')); ?>">
          <?php echo Form::getTokenHTML(); ?>
          <input type="hidden" name="action" value="assign">
          <input type="hidden" name="request_id" value="<?php echo (int)$request['id']; ?>">
          <label>
            Room
            <select name="room_id" required>
              <?php foreach ($editable_rooms as $room_option): ?>
                <option value="<?php echo (int)$room_option['id']; ?>">
                  <?php echo escape_html($room_option['area_name'] . ' - ' . $room_option['room_name']); ?>
                </option>
              <?php endforeach; ?>
            </select>
          </label>
          <label>
            Approval comments
            <textarea name="admin_note"></textarea>
          </label>
          <input type="submit" value="Assign and Approve">
        </form>

        <form method="post" action="<?php echo escape_html(multisite('pending_requests.php')); ?>">
          <?php echo Form::getTokenHTML(); ?>
          <input type="hidden" name="action" value="deny">
          <input type="hidden" name="request_id" value="<?php echo (int)$request['id']; ?>">
          <label>
            Denial reason
            <select name="denial_reason" required>
              <option value="">Select a reason</option>
              <option>Space unavailable</option>
              <option>Policy conflict</option>
              <option>Insufficient information</option>
              <option>Staffing or setup unavailable</option>
              <option>Duplicate request</option>
              <option>Other</option>
            </select>
          </label>
          <label>
            Comments
            <textarea name="denial_comment"></textarea>
          </label>
          <input type="submit" value="Deny Request">
        </form>
      </section>
    <?php endforeach; ?>
  <?php endif; ?>
</main>

<?php
print_footer();
