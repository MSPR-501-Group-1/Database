-- Change: schema_add_ingredient_usda_name
-- Date: 2026-04-16
-- Purpose: rollback ingredient.usda_name addition

BEGIN;

ALTER TABLE ingredient
  DROP COLUMN IF EXISTS usda_name;

COMMIT;
