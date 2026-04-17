# Exemples de migrations

Ce dossier contient des migrations de demonstration pour illustrer un flux complet de migration SQL.

Ces scripts sont a but documentaire uniquement.

## Scenarios couverts

1. Creation d une table
- `20260416_DEMO_create_migration_demo_table.up.sql`
- `20260416_DEMO_create_migration_demo_table.down.sql`

2. Insertion de donnees idempotente
- `20260417_DEMO_insert_rows_into_migration_demo_table.up.sql`
- `20260417_DEMO_insert_rows_into_migration_demo_table.down.sql`

3. Ajout d un champ + suppression du champ au rollback
- `20260417_DEMO_add_demo_status_column.up.sql`
- `20260417_DEMO_add_demo_status_column.down.sql`

## Ordre de test recommande

1. Appliquer les scripts UP dans cet ordre:
- creation de table
- insertion de lignes
- ajout de champ

2. Verifier:
- table presente
- donnees presentes
- colonne `demo_status` presente et peuplee

3. Appliquer les scripts DOWN dans l ordre inverse:
- suppression de champ
- suppression des lignes inserees
- suppression de table

Ce parcours permet de couvrir un minimum realiste: creation, insertion, evolution de schema et rollback.
