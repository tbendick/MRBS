<?php
declare(strict_types=1);
namespace MRBS;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
ensure_event_request_schema();

$mrbs_user = session()->getCurrentUser();
list($filter_sql, $params) = event_request_user_filter($mrbs_user);

$sql = "SELECT *
          FROM " . event_request_table() . "
         WHERE $filter_sql
      ORDER BY requested_start DESC, id DESC";

$res = db()->query($sql, $params);
$rows = [];
while (false !== ($row = $res->next_row_keyed()))
{
  $rows[] = $row;
}

print_header();
?>

<style>
.events_shell {
  max-width: 1100px;
  margin: 0 auto;
  padding: 1rem;
}

.events_top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.events_notice {
  border: 1px solid #86a86a;
  border-radius: 8px;
  padding: 0.75rem 1rem;
  background: #f3f8ef;
}

.events_table {
  width: 100%;
  margin-top: 1rem;
  border-collapse: collapse;
}

.events_table th,
.events_table td {
  padding: 0.65rem;
  border-bottom: 1px solid #d6dce5;
  text-align: left;
  vertical-align: top;
}

.events_status {
  display: inline-block;
  padding: 0.2rem 0.45rem;
  border-radius: 999px;
  background: #fff7ed;
  color: #9a3412;
  font-size: 0.85rem;
}

@media (max-width: 720px) {
  .events_top {
    align-items: flex-start;
    flex-direction: column;
  }

  .events_table,
  .events_table tbody,
  .events_table tr,
  .events_table td {
    display: block;
  }

  .events_table thead {
    display: none;
  }

  .events_table td {
    padding: 0.45rem 0;
  }
}
</style>

<main class="events_shell">
  <div class="events_top">
    <h1>My Events</h1>
    <a href="<?php echo escape_html(multisite('request_event.php')); ?>">Request event</a>
  </div>

  <?php if (get_form_var('saved', 'bool', false)): ?>
    <p class="events_notice">Your event request has been saved.</p>
  <?php endif; ?>

  <?php if (count($rows) === 0): ?>
    <p>No event requests found for your account email yet.</p>
  <?php else: ?>
    <table class="events_table">
      <thead>
        <tr>
          <th>Event</th>
          <th>Requester</th>
          <th>When</th>
          <th>People</th>
          <th>Status</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($rows as $row): ?>
          <tr>
            <td>
              <strong><?php echo escape_html($row['event_name']); ?></strong><br>
              <?php echo escape_html($row['department'] ?? ''); ?>
            </td>
            <td>
              <?php echo escape_html($row['requester_name']); ?><br>
              <?php echo escape_html($row['requester_email']); ?>
            </td>
            <td>
              <?php echo escape_html(time_date_string((int)$row['requested_start'])); ?><br>
              to <?php echo escape_html(time_date_string((int)$row['requested_end'])); ?>
            </td>
            <td><?php echo (int)$row['quantity']; ?></td>
            <td><span class="events_status"><?php echo escape_html(event_request_status_label($row['status'])); ?></span></td>
            <td><a href="<?php echo escape_html(multisite('request_event.php?id=' . (int)$row['id'])); ?>">Edit</a></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php endif; ?>
</main>

<?php
print_footer();
