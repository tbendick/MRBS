<?php
declare(strict_types=1);
namespace MRBS;

use MRBS\Form\Form;

require "defaultincludes.inc";
require_once "event_requests.inc";

checkAuthorised(this_page());
ensure_event_request_schema();

if (!is_admin())
{
  showAccessDenied($view, $view_all, $year, $month, $day, $area ?? null, isset($room) ? $room : null);
  exit;
}

$message = null;
$errors = [];
$field_types = event_request_field_types();

if (($server['REQUEST_METHOD'] ?? '') === 'POST')
{
  Form::checkToken();
  $action = get_form_var('action', 'string', '', INPUT_POST);
  $now = time();

  if ($action === 'save')
  {
    $id = get_form_var('id', 'int', null, INPUT_POST);
    $label = trim((string)get_form_var('label', 'string', '', INPUT_POST));
    $field_key = event_request_normalize_field_key((string)get_form_var('field_key', 'string', '', INPUT_POST), event_request_normalize_field_key($label));
    $field_type = get_form_var('field_type', 'string', 'text', INPUT_POST);
    $options = trim((string)get_form_var('options', 'string', '', INPUT_POST));
    $help_text = trim((string)get_form_var('help_text', 'string', '', INPUT_POST));
    $sort_order = (int)get_form_var('sort_order', 'int', 0, INPUT_POST);
    $is_required = get_form_var('is_required', 'bool', false, INPUT_POST) ? 1 : 0;
    $is_enabled = get_form_var('is_enabled', 'bool', false, INPUT_POST) ? 1 : 0;

    if ($label === '')
    {
      $errors[] = 'Field label is required.';
    }
    if (!array_key_exists($field_type, $field_types))
    {
      $errors[] = 'Invalid field type.';
    }
    if (($field_type === 'select') && ($options === ''))
    {
      $errors[] = 'Dropdown fields need one option per line.';
    }

    if (count($errors) === 0)
    {
      if (isset($id))
      {
        $sql = "UPDATE " . event_request_field_table() . "
                   SET label = :label,
                       field_key = :field_key,
                       field_type = :field_type,
                       options = :options,
                       help_text = :help_text,
                       is_required = :is_required,
                       is_enabled = :is_enabled,
                       sort_order = :sort_order,
                       updated_at = :updated_at
                 WHERE id = :id";
        db()->command($sql, [
          ':label' => $label,
          ':field_key' => $field_key,
          ':field_type' => $field_type,
          ':options' => $options,
          ':help_text' => $help_text,
          ':is_required' => $is_required,
          ':is_enabled' => $is_enabled,
          ':sort_order' => $sort_order,
          ':updated_at' => $now,
          ':id' => $id
        ]);
        $message = 'Intake field updated.';
      }
      else
      {
        $base_key = $field_key;
        $suffix = 2;
        while (db()->query1("SELECT COUNT(*) FROM " . event_request_field_table() . " WHERE field_key = :field_key", [':field_key' => $field_key]) > 0)
        {
          $field_key = substr($base_key, 0, 65) . '_' . $suffix;
          $suffix++;
        }
        $sql = "INSERT INTO " . event_request_field_table() . "
                      (field_key, label, field_type, options, help_text, is_required, is_enabled, sort_order, created_at, updated_at)
                VALUES (:field_key, :label, :field_type, :options, :help_text, :is_required, :is_enabled, :sort_order, :created_at, :updated_at)";
        db()->command($sql, [
          ':field_key' => $field_key,
          ':label' => $label,
          ':field_type' => $field_type,
          ':options' => $options,
          ':help_text' => $help_text,
          ':is_required' => $is_required,
          ':is_enabled' => $is_enabled,
          ':sort_order' => $sort_order,
          ':created_at' => $now,
          ':updated_at' => $now
        ]);
        $message = 'Intake field added.';
      }
    }
  }
  elseif ($action === 'delete')
  {
    $id = get_form_var('id', 'int', null, INPUT_POST);
    if (isset($id))
    {
      db()->command("DELETE FROM " . event_request_field_table() . " WHERE id = :id", [':id' => $id]);
      $message = 'Intake field deleted.';
    }
  }
}

$edit_id = get_form_var('edit', 'int');
$edit_field = null;
if (isset($edit_id))
{
  $res = db()->query("SELECT * FROM " . event_request_field_table() . " WHERE id = :id", [':id' => $edit_id]);
  $edit_field = $res->next_row_keyed();
}

$blank = [
  'id' => null,
  'field_key' => '',
  'label' => '',
  'field_type' => 'text',
  'options' => '',
  'help_text' => '',
  'is_required' => 0,
  'is_enabled' => 1,
  'sort_order' => 0
];
$form_field = isset($edit_field) && ($edit_field !== false) ? ($edit_field + $blank) : $blank;
$fields = event_request_fields(false);

print_header();
?>

<style>
.intake_shell { max-width: 1100px; margin: 0 auto; padding: 1rem; }
.intake_grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 1rem; }
.intake_field { display: flex; flex-direction: column; gap: 0.35rem; }
.intake_field.full { grid-column: 1 / -1; }
.intake_field input, .intake_field textarea, .intake_field select { box-sizing: border-box; width: 100%; }
.intake_table { width: 100%; border-collapse: collapse; margin-top: 1.5rem; }
.intake_table th, .intake_table td { border-bottom: 1px solid #d6dce5; padding: 0.65rem; text-align: left; vertical-align: top; }
.intake_actions { display: flex; gap: 0.5rem; align-items: center; }
@media (max-width: 720px) { .intake_grid { grid-template-columns: 1fr; } }
</style>

<main class="intake_shell">
  <h1>Intake Form Fields</h1>
  <p>Add, hide, require, or reorder extra fields on the event request intake form.</p>

  <?php if (isset($message)): ?><p><?php echo escape_html($message); ?></p><?php endif; ?>
  <?php foreach ($errors as $error): ?><p><?php echo escape_html($error); ?></p><?php endforeach; ?>

  <form method="post" action="<?php echo escape_html(multisite('intake_fields.php')); ?>">
    <?php echo Form::getTokenHTML(); ?>
    <input type="hidden" name="action" value="save">
    <?php if (isset($form_field['id'])): ?><input type="hidden" name="id" value="<?php echo (int)$form_field['id']; ?>"><?php endif; ?>

    <div class="intake_grid">
      <label class="intake_field">
        <span>Label</span>
        <input name="label" value="<?php echo escape_html($form_field['label']); ?>" required>
      </label>
      <label class="intake_field">
        <span>Field key</span>
        <input name="field_key" value="<?php echo escape_html($form_field['field_key']); ?>" placeholder="auto-created from label">
      </label>
      <label class="intake_field">
        <span>Type</span>
        <select name="field_type">
          <?php foreach ($field_types as $type => $label): ?>
            <option value="<?php echo escape_html($type); ?>" <?php echo ($form_field['field_type'] === $type) ? 'selected' : ''; ?>><?php echo escape_html($label); ?></option>
          <?php endforeach; ?>
        </select>
      </label>
      <label class="intake_field">
        <span>Sort order</span>
        <input type="number" name="sort_order" value="<?php echo (int)$form_field['sort_order']; ?>">
      </label>
      <label class="intake_field full">
        <span>Dropdown options</span>
        <textarea name="options" placeholder="One option per line"><?php echo escape_html($form_field['options'] ?? ''); ?></textarea>
      </label>
      <label class="intake_field full">
        <span>Help text</span>
        <input name="help_text" value="<?php echo escape_html($form_field['help_text'] ?? ''); ?>">
      </label>
      <label><input type="checkbox" name="is_required" value="1" <?php echo !empty($form_field['is_required']) ? 'checked' : ''; ?>> Required</label>
      <label><input type="checkbox" name="is_enabled" value="1" <?php echo !empty($form_field['is_enabled']) ? 'checked' : ''; ?>> Enabled</label>
    </div>

    <p class="intake_actions">
      <input type="submit" value="<?php echo isset($form_field['id']) ? 'Update Field' : 'Add Field'; ?>">
      <?php if (isset($form_field['id'])): ?><a href="<?php echo escape_html(multisite('intake_fields.php')); ?>">Cancel edit</a><?php endif; ?>
    </p>
  </form>

  <table class="intake_table">
    <thead><tr><th>Order</th><th>Label</th><th>Type</th><th>Required</th><th>Enabled</th><th>Actions</th></tr></thead>
    <tbody>
      <?php if (count($fields) === 0): ?>
        <tr><td colspan="6">No custom intake fields yet.</td></tr>
      <?php endif; ?>
      <?php foreach ($fields as $field): ?>
        <tr>
          <td><?php echo (int)$field['sort_order']; ?></td>
          <td><strong><?php echo escape_html($field['label']); ?></strong><br><small><?php echo escape_html($field['field_key']); ?></small></td>
          <td><?php echo escape_html($field_types[$field['field_type']] ?? $field['field_type']); ?></td>
          <td><?php echo !empty($field['is_required']) ? 'Yes' : 'No'; ?></td>
          <td><?php echo !empty($field['is_enabled']) ? 'Yes' : 'No'; ?></td>
          <td class="intake_actions">
            <a href="<?php echo escape_html(multisite('intake_fields.php?edit=' . (int)$field['id'])); ?>">Edit</a>
            <form method="post" action="<?php echo escape_html(multisite('intake_fields.php')); ?>" onsubmit="return confirm('Delete this intake field? Existing answers for this field will also be removed.');">
              <?php echo Form::getTokenHTML(); ?>
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="id" value="<?php echo (int)$field['id']; ?>">
              <input type="submit" value="Delete">
            </form>
          </td>
        </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</main>

<?php
print_footer();
