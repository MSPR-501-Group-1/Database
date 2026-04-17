-- Rollback de demonstration (pedagogique uniquement)
-- Scenario: suppression des donnees inserees par le script UP

BEGIN;

DELETE FROM migration_demo_table
WHERE demo_code IN ('DEMO_001', 'DEMO_002');

COMMIT;
