# Event Booking System Blueprint

This project starts from MRBS, but the new product direction is broader than room booking. The goal is a public-facing event request and calendar system with authenticated requester accounts, printable calendars, operational reports, and strong email/audit trails.

## Product Areas

### 1. Landing Page

The landing page should be a clean public gateway, not the calendar itself.

Primary actions:

- View calendar
- Print reports and calendar views
- Request or update an event, login required
- Login to account

Recommended first version:

- Public page at `home.php` or a routed equivalent.
- Existing MRBS calendar remains available at `index.php`.
- Header uses organization name/logo from existing MRBS config.
- Login state determines whether the request/update action goes directly to the request dashboard or to login.

### 2. Calendar View

The current MRBS calendar is a strong base and should be preserved early.

Carry forward:

- Day, week, month, and year views.
- Area and room selection.
- Single-room and all-room modes.
- Booking color/type key.
- Existing visibility and privacy rules.

Enhance later:

- Cleaner public calendar entry summaries.
- Filters for room, event type, approval state, and requester.
- Print-friendly calendar route with simpler controls.

### 3. Print Reports And Calendars

Reports should split into two families: calendar printouts and operational reports.

Calendar printouts:

- Single space calendar.
- Multiple spaces in one area.
- All spaces in selected areas.
- Day, week, month, and custom date range.
- Print rules for hiding private details and showing only approved/confirmed bookings.

Operational reports:

- Room usage by date range.
- Total booking hours by room.
- Event counts by room, area, type, requester, and status.
- Denied booking count by reason.
- Pending approval aging.
- Cancelled or deleted bookings.

Recommended first version:

- Add saved report definitions so common reports can be reused.
- Extend current `report.php` queries instead of replacing them immediately.
- Export CSV and printable HTML first; PDF can come later.

### 4. Request And Update Events

Each event should be tied to a requester account so the requester can log in, see their events, and update them.

Current MRBS stores the creator in `mrbs_entry.create_by`. Keep that as a compatibility field, but add a stronger requester relationship.

Recommended workflow:

1. Requester logs in.
2. Requester creates an event request.
3. System sends confirmation email to requester.
4. Admin reviews request.
5. Admin approves, requests more information, denies, or cancels.
6. System emails requester on every significant status change.
7. Requester can update permitted details until the event reaches a locked state.

Important rules:

- Approved events may need admin approval before requester edits take effect.
- Denials should require a structured reason and optional note.
- All state changes should be recorded in an audit table.

### 5. Login And Profile

MRBS already has user records, authentication, password reset, display name, email, and last login.

Recommended first version:

- Keep MRBS auth for the initial system.
- Add a user dashboard for requester-facing tasks.
- Let users update display name, email, phone, and organization/group.
- Keep admin user management separate from requester profile editing.

## Proposed Pages

Public:

- `/home.php` - landing page.
- `/index.php` - calendar view.
- `/print_calendar.php` - printable calendar builder.
- `/report.php` - current report page, later expanded.
- `/login.php` or existing MRBS login entry point.

Authenticated requester:

- `/request_event.php` - create new event request.
- `/my_events.php` - requester dashboard.
- `/update_event.php?id=...` - update owned event.
- `/profile.php` - profile details and contact preferences.

Admin:

- `/pending.php` - current approval queue, later enhanced.
- `/event_admin.php?id=...` - approve, deny, request info, cancel.
- `/report_templates.php` - saved reports and print presets.

## Data Model Extensions

The existing schema already has:

- `mrbs_users`
- `mrbs_area`
- `mrbs_room`
- `mrbs_entry`
- `mrbs_repeat`
- `mrbs_participants`

Add:

- Requester profile fields on `mrbs_users`.
- Request ownership fields on `mrbs_entry` and `mrbs_repeat`.
- Denial/cancellation reason tables.
- Event audit/history table.
- Saved report/print template table.

See `docs/schema-extension-draft.sql` for a starter migration.

## Reporting Metrics

Room usage:

- Booked seconds/hours per room.
- Percent of available room time used.
- Number of bookings per room.
- Average booking duration.

Request workflow:

- Requested count.
- Approved count.
- Denied count.
- Cancelled count.
- Pending count.
- Denials grouped by reason.
- Average time from request to approval/denial.

Requester activity:

- Bookings by requester.
- Repeat requesters.
- No-show tracking, if added later.

## Suggested Implementation Phases

### Phase 1: Product Shell

- Add landing page.
- Preserve existing calendar as the main calendar route.
- Add requester dashboard placeholder.
- Add profile route using existing auth.

### Phase 2: Ownership And Workflow

- Add schema extensions.
- Tie bookings to `requester_user_id`.
- Add audit trail.
- Add denial reasons.
- Update approval/rejection handlers to store structured history.

### Phase 3: Email Improvements

- Ensure requester emails fire on request, approval, denial, update, cancellation, and request-more-info.
- Add templates or clearer message blocks.
- Include event details and direct update links.

### Phase 4: Print And Reports

- Add printable calendar builder.
- Add saved report definitions.
- Add usage and denial reports.
- Add CSV export.

### Phase 5: UI Modernization

- Refresh landing page and requester/admin task screens.
- Keep calendar behavior stable while improving presentation.
- Add filters and status badges.

## First Decisions To Confirm

- Should this stay as a PHP/MRBS customization, or become a new app that imports MRBS data?
- Should public users be allowed to view event details, or only availability blocks?
- Should requesters self-register, or should accounts be created by staff?
- Are event updates always allowed before approval, or should some fields lock immediately?
- Which denial reasons should be available by default?
