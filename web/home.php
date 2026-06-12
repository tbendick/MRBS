<?php
declare(strict_types=1);
namespace MRBS;

require "defaultincludes.inc";

function home_link(string $href, string $label, string $meta, string $class='') : string
{
  $classes = trim("home_action $class");

  return '<a class="' . escape_html($classes) . '" href="' . escape_html(multisite($href)) . '">' .
         '<span class="home_action_label">' . escape_html($label) . '</span>' .
         '<span class="home_action_meta">' . escape_html($meta) . '</span>' .
         '</a>';
}

$mrbs_user = session()->getCurrentUser();
$is_logged_in = isset($mrbs_user) && ($mrbs_user->username !== '');
$display_name = ($is_logged_in && isset($mrbs_user->display_name) && ($mrbs_user->display_name !== ''))
  ? $mrbs_user->display_name
  : (($is_logged_in) ? $mrbs_user->username : '');

print_header();
?>

<style>
.home_shell {
  max-width: 1120px;
  margin: 0 auto;
  padding: 2rem 1rem 3rem;
}

.home_title {
  margin: 0 0 0.35rem;
  font-size: 2rem;
  line-height: 1.15;
  letter-spacing: 0;
}

.home_intro {
  max-width: 680px;
  margin: 0 0 1.5rem;
  color: #4b5563;
  font-size: 1rem;
}

.home_grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 0.85rem;
  margin: 1.25rem 0 1.5rem;
}

.home_action {
  display: flex;
  min-height: 8.5rem;
  flex-direction: column;
  justify-content: space-between;
  padding: 1rem;
  border: 1px solid #d6dce5;
  border-left: 0.35rem solid #2f6f9f;
  border-radius: 8px;
  background: #ffffff;
  color: #172033;
  text-decoration: none;
}

.home_action:focus,
.home_action:hover {
  border-color: #245a83;
  background: #f7fbff;
}

.home_action.request {
  border-left-color: #4f7d35;
}

.home_action.login {
  border-left-color: #7666a8;
}

.home_action.report {
  border-left-color: #b85f28;
}

.home_action_label {
  display: block;
  font-size: 1.15rem;
  font-weight: 700;
  line-height: 1.25;
}

.home_action_meta {
  display: block;
  margin-top: 1rem;
  color: #4b5563;
  font-size: 0.9rem;
  line-height: 1.35;
}

.home_panel {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  padding: 1rem;
  border: 1px solid #d6dce5;
  border-radius: 8px;
  background: #f8fafc;
}

.home_panel h2 {
  margin: 0 0 0.25rem;
  font-size: 1rem;
  letter-spacing: 0;
}

.home_panel p {
  margin: 0;
  color: #4b5563;
}

.home_panel a {
  white-space: nowrap;
}

@media (max-width: 900px) {
  .home_grid {
    grid-template-columns: repeat(2, minmax(0, 1fr));
  }
}

@media (max-width: 560px) {
  .home_shell {
    padding-top: 1rem;
  }

  .home_grid {
    grid-template-columns: 1fr;
  }

  .home_panel {
    align-items: flex-start;
    flex-direction: column;
  }

  .home_panel a {
    white-space: normal;
  }
}
</style>

<main class="home_shell">
  <h1 class="home_title"><?php echo escape_html($mrbs_company); ?> Event Booking</h1>
  <p class="home_intro">Calendar access, event requests, reports, and account tools.</p>

  <section class="home_grid" aria-label="Main actions">
    <?php
    echo home_link('index.php', 'View Calendar', 'Day, week, month, and room views.');
    echo home_link('custom_reports.php', 'Print Reports / Calendar Views', 'Weekly classroom and building assignment printouts.', 'report');
    echo home_link('request_event.php', 'Request / Update Event', 'Login required for event changes.', 'request');
    if (function_exists(__NAMESPACE__ . '\\is_admin') && is_admin())
    {
      echo home_link('intake_fields.php', 'Intake Form Admin', 'Add, hide, require, or reorder request form fields.', 'admin');
    }
    echo home_link($is_logged_in ? 'my_events.php' : 'pending.php', $is_logged_in ? 'My Events' : 'Login To Account', $is_logged_in ? $display_name : 'Access your bookings and profile.', 'login');
    ?>
  </section>

  <section class="home_panel" aria-label="Account status">
    <div>
      <h2><?php echo $is_logged_in ? 'Signed In' : 'Account'; ?></h2>
      <p>
        <?php
        echo $is_logged_in
          ? escape_html(format_compound_name($mrbs_user->username, $display_name))
          : 'Login is required to request or update events.';
        ?>
      </p>
    </div>
    <a href="<?php echo escape_html(multisite($is_logged_in ? 'my_events.php' : 'pending.php')); ?>">
      <?php echo $is_logged_in ? 'My Events' : 'Login'; ?>
    </a>
  </section>
</main>

<?php
print_footer();
