# README - Migrations SQL (guide professionnel)

## 1) Pourquoi ce dossier existe

Ce dossier porte la strategie de versionnement du schema relationnel PostgreSQL.

Objectifs:

1. garantir des evolutions SQL incrementales,
2. assurer la reproductibilite des environnements,
3. permettre un rollback testable,
4. conserver une trace auditable des changements physiques (MPD).

## 2) Structure recommandee

1. `database/migrations/*.up.sql` : script d'application.
2. `database/migrations/*.down.sql` : script de retour arriere.
3. `database/migrations/examples/` : migrations de demonstration (pedagogiques, hors flux production).

## 3) Conventions de nommage

Format conseille:

1. `YYYYMMDD_<contexte>_<action>.up.sql`
2. `YYYYMMDD_<contexte>_<action>.down.sql`

Exemples:

1. `20260416_schema_add_ingredient_usda_name.up.sql`
2. `20260416_schema_add_ingredient_usda_name.down.sql`

Bonnes pratiques:

1. nom lisible et stable,
2. une migration = une intention technique,
3. ne pas melanger plusieurs sujets non relies dans un meme script.

## 4) Standards de qualite SQL

Chaque script doit:

1. contenir un entete de contexte,
2. etre idempotent quand c'est possible,
3. utiliser une transaction (ACID) explicite si l'operation le permet,
4. rester non-destructif par defaut,
5. documenter clairement les impacts du `down`.

Note importante:

Certaines operations PostgreSQL (ex: `CREATE INDEX CONCURRENTLY`) ne sont pas compatibles avec un bloc transactionnel `BEGIN/COMMIT`.

## 5) Tutoriel complet de reproductibilite (pas a pas)

Le tutoriel ci-dessous utilise **des migrations de test** pour illustrer plusieurs cas sans impacter les tables metier.

Fichiers de demonstration utilises:

1. `database/migrations/examples/20260416_DEMO_create_migration_demo_table.up.sql`
2. `database/migrations/examples/20260416_DEMO_create_migration_demo_table.down.sql`
3. `database/migrations/examples/20260417_DEMO_insert_rows_into_migration_demo_table.up.sql`
4. `database/migrations/examples/20260417_DEMO_insert_rows_into_migration_demo_table.down.sql`
5. `database/migrations/examples/20260417_DEMO_add_demo_status_column.up.sql`
6. `database/migrations/examples/20260417_DEMO_add_demo_status_column.down.sql`

### Etape 0 - Prerequis

1. Docker actif.
2. Conteneur PostgreSQL disponible (`database`).
3. Projet positionne a la racine du workspace.

### Etape 1 - Backup obligatoire avant tout changement

```powershell
docker exec database pg_dump -U admin -d database |
  Out-File -FilePath audit/db/pre-migration-YYYY-MM-DD.sql -Encoding utf8
```

Verification automatique:

```powershell
Get-Item audit/db/pre-migration-YYYY-MM-DD.sql | Select-Object Name, Length, LastWriteTime
```

Resultat attendu:

1. fichier present,
2. taille non nulle,
3. horodatage coherent.

### Etape 2 - Appliquer les migrations de test (UP)

```powershell
Get-Content database/migrations/examples/20260416_DEMO_create_migration_demo_table.up.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database

Get-Content database/migrations/examples/20260417_DEMO_insert_rows_into_migration_demo_table.up.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database

Get-Content database/migrations/examples/20260417_DEMO_add_demo_status_column.up.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database
```

Resultat attendu:

1. `BEGIN`
2. `CREATE TABLE` (pour le premier script)
3. `INSERT` (pour le second script)
4. `ALTER TABLE` + `UPDATE` (pour le troisieme script)
5. `COMMIT`

### Etape 3 - Verifier le resultat de la migration

```powershell
docker exec database psql -U admin -d database -c "
SELECT table_name
FROM information_schema.tables
WHERE table_schema='public'
  AND table_name='migration_demo_table';"
```

Resultat attendu:

Une ligne retournee: `migration_demo_table`.

Verification des donnees inserees:

```powershell
docker exec database psql -U admin -d database -c "
SELECT demo_code, demo_label
FROM migration_demo_table
WHERE demo_code IN ('DEMO_001', 'DEMO_002')
ORDER BY demo_code;"
```

Verification du champ ajoute:

```powershell
docker exec database psql -U admin -d database -c "
SELECT column_name
FROM information_schema.columns
WHERE table_schema='public'
  AND table_name='migration_demo_table'
  AND column_name='demo_status';"
```

Resultat attendu:

1. 2 lignes pour `DEMO_001` et `DEMO_002`,
2. colonne `demo_status` presente.

### Etape 4 - Tester le rollback (DOWN)

```powershell
Get-Content database/migrations/examples/20260417_DEMO_add_demo_status_column.down.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database

Get-Content database/migrations/examples/20260417_DEMO_insert_rows_into_migration_demo_table.down.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database

Get-Content database/migrations/examples/20260416_DEMO_create_migration_demo_table.down.sql |
  docker exec -i database psql -v ON_ERROR_STOP=1 -U admin -d database
```

Important: appliquer les scripts DOWN dans l ordre inverse des UP:

1. `20260417_DEMO_add_demo_status_column.down.sql`
2. `20260417_DEMO_insert_rows_into_migration_demo_table.down.sql`
3. `20260416_DEMO_create_migration_demo_table.down.sql`

Verification:

```powershell
docker exec database psql -U admin -d database -tAc "
SELECT EXISTS (
  SELECT 1
  FROM information_schema.tables
  WHERE table_schema='public'
    AND table_name='migration_demo_table'
);"
```

Resultat attendu:

Table absente apres rollback.

Verification complementaire (colonne supprimee):

```powershell
docker exec database psql -U admin -d database -tAc "
SELECT EXISTS (
  SELECT 1
  FROM information_schema.columns
  WHERE table_schema='public'
    AND table_name='migration_demo_table'
    AND column_name='demo_status'
);"
```

Resultat attendu: `f`.

### Etape 5 - Valider la reproductibilite from-scratch

```powershell
docker compose down -v
docker compose up -d --build db backend
docker compose ps
```

Resultat attendu:

1. service `db` en `healthy`,
2. service `backend` en `healthy`.

## 6) Mode operatoire pour une vraie migration

Apres validation avec les migrations de test:

1. creer un couple `up/down` dans `database/migrations/`,
2. appliquer la meme sequence (backup -> up -> verifications -> down -> re-up),
3. executer des checks applicatifs minimaux,
4. documenter commandes et resultats dans un journal d execution.

## 7) Checklist de sortie

Une migration est consideree prete quand:

1. `up` et `down` existent,
2. `up` est rejouable ou defensif,
3. rollback execute au moins une fois,
4. backup pre-migration confirme,
5. controle SQL post-application valide,
6. controle applicatif minimal valide,
7. documentation mise a jour.
