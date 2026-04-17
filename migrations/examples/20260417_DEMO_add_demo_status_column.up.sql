-- Migration de demonstration (pedagogique uniquement)
-- Scenario: ajout d un champ + backfill idempotent
-- Prerequis: table migration_demo_table deja creee

BEGIN;

ALTER TABLE IF EXISTS migration_demo_table
  ADD COLUMN IF NOT EXISTS demo_status VARCHAR(20);

UPDATE migration_demo_table
SET demo_status = COALESCE(demo_status, 'ACTIVE')
WHERE demo_code IN ('DEMO_001', 'DEMO_002');

COMMIT;
