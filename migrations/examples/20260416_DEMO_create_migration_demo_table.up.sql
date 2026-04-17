-- Migration de demonstration (pedagogique uniquement)
-- Ce script est volontairement isole dans migrations/examples.
-- Il ne fait pas partie du flux de migration production.

BEGIN;

CREATE TABLE IF NOT EXISTS migration_demo_table (
  demo_id UUID DEFAULT gen_random_uuid(),
  demo_code VARCHAR(40) NOT NULL UNIQUE,
  demo_label VARCHAR(120) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(demo_id)
);

COMMIT;
