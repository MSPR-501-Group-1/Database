-- Rollback de demonstration (pedagogique uniquement)
-- Scenario: suppression du champ ajoute dans le script UP

BEGIN;

ALTER TABLE IF EXISTS migration_demo_table
  DROP COLUMN IF EXISTS demo_status;

COMMIT;
