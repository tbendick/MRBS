<?php
declare(strict_types=1);
namespace MRBS;

use MRBS\Form\Form;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
if (!is_admin())
{
  showAccessDenied($view, $view_all, $year, $month, $day, $area ?? null, isset($room) ? $room : null);
  exit;
}

ensure_event_request_schema();
$mrbs_user = session()->getCurrentUser();
$message = null;

if (($server['REQUEST_METHOD'] ?? '') === 'POST')
{
  Form::checkToken();
  $action = get_form_var('action', 'string', '', INPUT_POST);
  $username = trim((string)get_form_var('username', 'string', '', INPUT_POST));
  $room_id = get_form_var('room_id', 'int', 0, INPUT_POST);

  if (($action === 'add') && ($username !== ''))
  {
    $sql = "INSERT IGNORE INTO " . room_editor_table() . "
                  (username, room_id, created_by, created_at)
            VALUES (:username, :room_id, :created_by, :created_at)";
    db()->command($sql, [
      ':username' => $username,
      ':room_id' => (int)$room_id,
      ':created_by' => $mrbs_user->username,
      ':created_at' => time()
    ]);
    $message = 'Editor assignment saved.';
  }
  elseif (($action === 'delete') && ($username !== ''))
  {
    $sql = "DELETE FROM " . room_editor_table() . "
            WHERE username = :username
              AND room_id = :room_id";
    db()->command($sql, [':username' => $username, ':room_id' => (int)$room_id]);
    $message = 'Editor assignment removed.';
  }
}

$rooms = current_user_editable_rooms();
$sql = "SELECT E.username, E.room_id, R.room_name, A.area_name
          FROM " . room_editor_table() . " E
     LEFT JOIN " . _tbl('room') . " R ON R.id = E.room_id
     LEFT JOIN " . _tbl('area') . " A ON A.id = R.area_id
      ORDER BY E.username, A.area_name, R.room_name";
$res = db()->query($sql);
$assignments = [];
while (false !== ($row = $res->next_row_keyed()))
{
  $assignments[] = $row;
}

print_header();
?>

<main class="contents">
  <h1>Editor Assignments</h1>
  <?php if (isset($message)): ?>
    <p><?php echo escape_html($message); ?></p>
  <?php endif; ?>

  <form method="post" action="<?php echo escape_html(multisite('editor_assignments.php')); ?>">
    <?php echo Form::getTokenHTML(); ?>
    <input type="hidden" name="action" value="add">
    <fieldset>
      <legend>Add Editor</legend>
      <label>
        Username
        <input name="username" required>
      </label>
      <label>
        Room scope
        <select name="room_id">
          <option value="0">All rooms</option>
          <?php foreach ($rooms as $editor_room): ?>
            <option value="<?php echo (int)$editor_room['id']; ?>">
              <?php echo escape_html($editor_room['area_name'] . ' - ' . $editor_room['room_name']); ?>
            </option>
          <?php endforeach; ?>
        </select>
      </label>
      <input type="submit" value="Add Editor">
    </fieldset>
  </form>

  <h2>Current Editors</h2>
  <?php if (count($assignments) === 0): ?>
    <p>No editor assignments yet.</p>
  <?php else: ?>
    <table>
      <thead>
        <tr>
          <th>Username</th>
          <th>Scope</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($assignments as $assignment): ?>
          <tr>
            <td><?php echo escape_html($assignment['username']); ?></td>
            <td>
              <?php
              echo ((int)$assignment['room_id'] === 0)
                ? 'All rooms'
                : escape_html($assignment['area_name'] . ' - ' . $assignment['room_name']);
              ?>
            </td>
            <td>
              <form method="post" action="<?php echo escape_html(multisite('editor_assignments.php')); ?>">
                <?php echo Form::getTokenHTML(); ?>
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="username" value="<?php echo escape_html($assignment['username']); ?>">
                <input type="hidden" name="room_id" value="<?php echo (int)$assignment['room_id']; ?>">
                <input type="submit" value="Remove">
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php endif; ?>
</main>

<?php
print_footer();
