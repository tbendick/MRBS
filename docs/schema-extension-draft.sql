-- Draft schema extensions for the new event booking system.
-- This is a planning migration, not yet wired into MRBS upgrade handling.

ALTER TABLE mrbs_users
  ADD COLUMN phone varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN organization varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN profile_notes text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL;

CREATE TABLE mrbs_denial_reason
(
  id          int NOT NULL auto_increment,
  reason      varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  description text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  active      tinyint DEFAULT 1 NOT NULL,
  sort_key    varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' NOT NULL,

  PRIMARY KEY (id),
  UNIQUE KEY uq_denial_reason (reason),
  KEY idxDenialReasonSortKey (sort_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO mrbs_denial_reason (reason, sort_key)
  VALUES
    ('Space unavailable', 'Space unavailable'),
    ('Policy conflict', 'Policy conflict'),
    ('Insufficient information', 'Insufficient information'),
    ('Staffing or setup unavailable', 'Staffing or setup unavailable'),
    ('Duplicate request', 'Duplicate request'),
    ('Other', 'Other');

ALTER TABLE mrbs_entry
  ADD COLUMN requester_user_id int DEFAULT NULL,
  ADD COLUMN requester_email varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN request_status varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'approved' NOT NULL,
  ADD COLUMN denial_reason_id int DEFAULT NULL,
  ADD COLUMN denial_note text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN requested_at int DEFAULT NULL COMMENT 'Unix timestamp',
  ADD COLUMN decided_at int DEFAULT NULL COMMENT 'Unix timestamp',
  ADD CONSTRAINT fk_entry_requester_user
    FOREIGN KEY (requester_user_id)
    REFERENCES mrbs_users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  ADD CONSTRAINT fk_entry_denial_reason
    FOREIGN KEY (denial_reason_id)
    REFERENCES mrbs_denial_reason(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  ADD KEY idxEntryRequesterUser (requester_user_id),
  ADD KEY idxEntryRequestStatus (request_status),
  ADD KEY idxEntryDenialReason (denial_reason_id);

ALTER TABLE mrbs_repeat
  ADD COLUMN requester_user_id int DEFAULT NULL,
  ADD COLUMN requester_email varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN request_status varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'approved' NOT NULL,
  ADD COLUMN denial_reason_id int DEFAULT NULL,
  ADD COLUMN denial_note text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN requested_at int DEFAULT NULL COMMENT 'Unix timestamp',
  ADD COLUMN decided_at int DEFAULT NULL COMMENT 'Unix timestamp',
  ADD CONSTRAINT fk_repeat_requester_user
    FOREIGN KEY (requester_user_id)
    REFERENCES mrbs_users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  ADD CONSTRAINT fk_repeat_denial_reason
    FOREIGN KEY (denial_reason_id)
    REFERENCES mrbs_denial_reason(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  ADD KEY idxRepeatRequesterUser (requester_user_id),
  ADD KEY idxRepeatRequestStatus (request_status),
  ADD KEY idxRepeatDenialReason (denial_reason_id);

CREATE TABLE mrbs_event_audit
(
  id              int NOT NULL auto_increment,
  entry_id        int DEFAULT NULL,
  repeat_id       int DEFAULT NULL,
  actor_user_id   int DEFAULT NULL,
  actor_username  varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  action          varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  from_status     varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  to_status       varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  reason_id       int DEFAULT NULL,
  note            text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  created_at      int NOT NULL COMMENT 'Unix timestamp',

  PRIMARY KEY (id),
  FOREIGN KEY (entry_id)
    REFERENCES mrbs_entry(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (repeat_id)
    REFERENCES mrbs_repeat(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (actor_user_id)
    REFERENCES mrbs_users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  FOREIGN KEY (reason_id)
    REFERENCES mrbs_denial_reason(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  KEY idxEventAuditEntry (entry_id),
  KEY idxEventAuditRepeat (repeat_id),
  KEY idxEventAuditAction (action),
  KEY idxEventAuditCreatedAt (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE mrbs_report_template
(
  id          int NOT NULL auto_increment,
  name        varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  type        varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  parameters  text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'JSON encoded',
  created_by  varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  created_at  int NOT NULL COMMENT 'Unix timestamp',
  updated_at  int NOT NULL COMMENT 'Unix timestamp',

  PRIMARY KEY (id),
  UNIQUE KEY uq_report_template_name (name),
  KEY idxReportTemplateType (type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
