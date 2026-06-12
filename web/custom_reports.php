<?php
declare(strict_types=1);
namespace MRBS;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
ensure_event_request_schema();

function report_week_start(?string $date_string) : int
{
  $time = isset($date_string) ? strtotime($date_string) : time();
  if ($time === false)
  {
    $time = time();
  }

  return strtotime('monday this week', $time);
}

function report_range_label(int $week_start) : string
{
  $week_end = strtotime('+5 days', $week_start);
  return 'WEEK OF MONDAY ' . date('F j, Y', $week_start) .
         ' through SATURDAY ' . date('F j, Y', $week_end);
}

function report_area_name(string $report) : string
{
  return ($report === 'buildings') ? 'Training Buildings' : 'Classrooms';
}

function report_title(string $report) : string
{
  return ($report === 'buildings') ? 'Weekly Building Assignments' : 'Weekly Classroom Assignments';
}

function report_room_rows(string $area_name) : array
{
  $sql = "SELECT R.id, R.room_name, R.description, R.capacity
            FROM " . _tbl('room') . " R
            JOIN " . _tbl('area') . " A ON A.id = R.area_id
           WHERE A.area_name = :area_name
             AND A.disabled = 0
             AND R.disabled = 0
        ORDER BY R.sort_key, R.room_name";
  $res = db()->query($sql, [':area_name' => $area_name]);

  $rows = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $row['id'] = (int)$row['id'];
    $row['capacity'] = (int)$row['capacity'];
    $rows[] = $row;
  }

  return $rows;
}

function report_entries_by_room(array $rooms, int $week_start) : array
{
  if (count($rooms) === 0)
  {
    return [];
  }

  $room_ids = array_column($rooms, 'id');
  $placeholders = [];
  $params = [
    ':start' => $week_start,
    ':end' => strtotime('+6 days', $week_start)
  ];

  foreach ($room_ids as $index => $room_id)
  {
    $key = ":room_$index";
    $placeholders[] = $key;
    $params[$key] = $room_id;
  }

  $sql = "SELECT id, room_id, name, description, start_time, end_time, status
            FROM " . _tbl('entry') . "
           WHERE room_id IN (" . implode(',', $placeholders) . ")
             AND start_time < :end
             AND end_time > :start
        ORDER BY start_time, name";
  $res = db()->query($sql, $params);

  $entries = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $room_id = (int)$row['room_id'];
    $day_key = date('Y-m-d', (int)$row['start_time']);
    $entries[$room_id][$day_key][] = $row;
  }

  return $entries;
}

function report_request_rows(int $week_start) : array
{
  $sql = "SELECT id, requester_name, requester_email, event_name, department,
                 requested_start, requested_end, quantity, status
            FROM " . event_request_table() . "
           WHERE requested_start >= :start
             AND requested_start < :end
             AND assigned_entry_id IS NULL
        ORDER BY requested_start, event_name";
  $res = db()->query($sql, [
    ':start' => $week_start,
    ':end' => strtotime('+6 days', $week_start)
  ]);

  $rows = [];
  while (false !== ($row = $res->next_row_keyed()))
  {
    $rows[] = $row;
  }

  return $rows;
}

function report_entry_text(array $entry) : string
{
  $time = date('Hi', (int)$entry['start_time']) . '-' . date('Hi', (int)$entry['end_time']);
  return trim($entry['name'] . ' ' . $time);
}

function report_day_cell(array $entries, int $room_id, int $day_time) : string
{
  $day_key = date('Y-m-d', $day_time);
  if (empty($entries[$room_id][$day_key]))
  {
    return '&nbsp;';
  }

  $parts = [];
  foreach ($entries[$room_id][$day_key] as $entry)
  {
    $parts[] = '<div>' . escape_html(report_entry_text($entry)) . '</div>';
  }

  return implode('', $parts);
}

function report_capacity_label(array $room) : string
{
  $parts = [];
  if (!empty($room['capacity']))
  {
    $parts[] = 'Size ' . (int)$room['capacity'];
  }
  if (!empty($room['description']))
  {
    $parts[] = $room['description'];
  }

  return implode(' | ', $parts);
}

$report = get_form_var('report', 'string', 'classrooms');
if (!in_array($report, ['classrooms', 'buildings']))
{
  $report = 'classrooms';
}

$week_start = report_week_start(get_form_var('week', 'string'));
$area_name = report_area_name($report);
$rooms = report_room_rows($area_name);
$entries = report_entries_by_room($rooms, $week_start);
$requests = report_request_rows($week_start);
$days = [];
for ($i = 0; $i < 6; $i++)
{
  $days[] = strtotime("+$i days", $week_start);
}

print_header();
?>

<style>
.custom_report {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem;
}

.custom_report_controls {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  align-items: end;
  margin: 1rem 0;
}

.custom_report_controls label {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.assignment_table,
.request_table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
}

.assignment_table th,
.assignment_table td,
.request_table th,
.request_table td {
  border: 1px solid #aeb7c2;
  padding: 0.45rem;
  vertical-align: top;
}

.assignment_table th {
  background: #eef3f8;
}

.room_meta {
  color: #4b5563;
  font-size: 0.85rem;
}

.report_print_actions {
  margin: 1rem 0;
}

@media print {
  .banner,
  .custom_report_controls,
  .report_print_actions {
    display: none;
  }

  .contents,
  .custom_report {
    margin: 0;
    max-width: none;
    padding: 0;
  }

  .assignment_table,
  .request_table {
    font-size: 10pt;
  }
}
</style>

<main class="custom_report">
  <h1><?php echo escape_html(report_title($report)); ?></h1>
  <p><?php echo escape_html(report_range_label($week_start)); ?></p>

  <form class="custom_report_controls" method="get" action="<?php echo escape_html(multisite('custom_reports.php')); ?>">
    <label>
      <span>Report</span>
      <select name="report">
        <option value="classrooms" <?php echo ($report === 'classrooms') ? 'selected' : ''; ?>>Classrooms</option>
        <option value="buildings" <?php echo ($report === 'buildings') ? 'selected' : ''; ?>>Training Buildings</option>
      </select>
    </label>
    <label>
      <span>Week</span>
      <input type="date" name="week" value="<?php echo escape_html(date('Y-m-d', $week_start)); ?>">
    </label>
    <input type="submit" value="Run Report">
  </form>

  <div class="report_print_actions">
    <button type="button" onclick="window.print()">Print</button>
  </div>

  <?php if (count($rooms) === 0): ?>
    <p>No rooms found for <?php echo escape_html($area_name); ?>.</p>
  <?php else: ?>
    <table class="assignment_table">
      <thead>
        <tr>
          <th><?php echo ($report === 'buildings') ? 'Building' : 'Classroom'; ?></th>
          <?php foreach ($days as $day): ?>
            <th><?php echo escape_html(date('l', $day)); ?><br><?php echo escape_html(date('n/j', $day)); ?></th>
          <?php endforeach; ?>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($rooms as $room): ?>
          <tr>
            <th>
              <?php echo escape_html($room['room_name']); ?>
              <?php if ($report === 'classrooms'): ?>
                <div class="room_meta"><?php echo escape_html(report_capacity_label($room)); ?></div>
              <?php endif; ?>
            </th>
            <?php foreach ($days as $day): ?>
              <td><?php echo report_day_cell($entries, (int)$room['id'], $day); ?></td>
            <?php endforeach; ?>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php endif; ?>

  <h2>Unassigned Event Requests</h2>
  <?php if (count($requests) === 0): ?>
    <p>No unassigned event requests for this week.</p>
  <?php else: ?>
    <table class="request_table">
      <thead>
        <tr>
          <th>When</th>
          <th>Event</th>
          <th>Requester</th>
          <th>People</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($requests as $request): ?>
          <tr>
            <td>
              <?php echo escape_html(time_date_string((int)$request['requested_start'])); ?><br>
              to <?php echo escape_html(time_date_string((int)$request['requested_end'])); ?>
            </td>
            <td>
              <?php echo escape_html($request['event_name']); ?><br>
              <?php echo escape_html($request['department'] ?? ''); ?>
            </td>
            <td>
              <?php echo escape_html($request['requester_name']); ?><br>
              <?php echo escape_html($request['requester_email']); ?>
            </td>
            <td><?php echo (int)$request['quantity']; ?></td>
            <td><?php echo escape_html(event_request_status_label($request['status'])); ?></td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  <?php endif; ?>
</main>

<?php
print_footer();
