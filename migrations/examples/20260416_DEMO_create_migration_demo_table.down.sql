-- Rollback de demonstration (pedagogique uniquement)
-- Ce script est volontairement isole dans migrations/examples.
-- Il ne fait pas partie du flux de migration production.

BEGIN;

DROP TABLE IF EXISTS migration_demo_table;

COMMIT;
