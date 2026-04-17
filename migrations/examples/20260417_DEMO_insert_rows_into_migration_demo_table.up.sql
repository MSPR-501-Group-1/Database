-- Migration de demonstration (pedagogique uniquement)
-- Scenario: insertion de donnees idempotente
-- Prerequis: table migration_demo_table deja creee

BEGIN;

INSERT INTO migration_demo_table (demo_code, demo_label)
VALUES
  ('DEMO_001', 'Ligne de demonstration 1'),
  ('DEMO_002', 'Ligne de demonstration 2')
ON CONFLICT (demo_code) DO UPDATE
SET demo_label = EXCLUDED.demo_label;

COMMIT;
