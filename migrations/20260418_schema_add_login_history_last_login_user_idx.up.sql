-- Change: schema_add_login_history_last_login_user_idx
-- Purpose: speed up analytics queries that filter by last_login and count distinct users.

BEGIN;

CREATE INDEX IF NOT EXISTS idx_login_history_last_login_user_id
  ON login_history (last_login DESC, user_id);

COMMIT;