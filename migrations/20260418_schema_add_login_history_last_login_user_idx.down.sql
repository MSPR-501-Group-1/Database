-- Change: schema_add_login_history_last_login_user_idx
-- Purpose: rollback login_history analytics index.

BEGIN;

DROP INDEX IF EXISTS idx_login_history_last_login_user_id;

COMMIT;