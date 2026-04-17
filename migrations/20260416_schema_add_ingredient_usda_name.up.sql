-- Change: schema_add_ingredient_usda_name
-- Date: 2026-04-16
-- Purpose: align schema with seed and ETL mapping by adding ingredient.usda_name

BEGIN;

ALTER TABLE ingredient
  ADD COLUMN IF NOT EXISTS usda_name VARCHAR(255);

COMMIT;
