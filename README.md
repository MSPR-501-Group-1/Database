# Database

Scripts SQL, versions de schema et documentation de la base PostgreSQL MSPR.

## Structure rapide

- Looping/: iterations des modeles Looping versionnees
- scripts/: scripts SQL versionnes (init / seed)
- 01_initdb.sql et 02_seed.sql: scripts utilises par le docker compose racine

## Usage avec Docker (recommande)

La base est demarree automatiquement depuis la racine du projet:

```bash
docker compose up --build db
```

PostgreSQL est expose sur localhost:5432.

## Installation manuelle PostgreSQL et pgAdmin4

Le guide detaille ci-dessous reste disponible pour une installation hors Docker.

# Installation PostgreSQL & pgAdmin4 - Base de donnees MSPR

Ce guide explique comment installer **PostgreSQL** et **pgAdmin4**, puis créer et initialiser la base de données **MSPR** à partir du script SQL fourni.

---

## 📋 Prérequis

- Système d'exploitation : Windows 10/11, macOS ou Linux (Ubuntu/Debian)
- Droits administrateur sur votre machine
- Connexion internet

---

## 1. Installation de PostgreSQL

### 🪟 Windows

1. Rendez-vous sur le site officiel : [https://www.postgresql.org/download/windows/](https://www.postgresql.org/download/windows/)
2. Cliquez sur **"Download the installer"** (via EDB)
3. Téléchargez la dernière version stable (ex : PostgreSQL 16.x)
4. Lancez l'installateur et suivez les étapes :
   - Choisissez le répertoire d'installation (par défaut : `C:\Program Files\PostgreSQL\16`)
   - Sélectionnez les composants : cochez **PostgreSQL Server**, **pgAdmin 4**, **Stack Builder**, **Command Line Tools**
   - Choisissez le répertoire des données (par défaut)
   - Définissez un **mot de passe** pour l'utilisateur `postgres` ⚠️ *Notez-le bien, il sera nécessaire plus tard* 
   - Port par défaut : **5432** (laissez tel quel)
   - Locale : laissez la valeur par défaut
5. Terminez l'installation

### 🍎 macOS

1. Rendez-vous sur : [https://www.postgresql.org/download/macosx/](https://www.postgresql.org/download/macosx/)
2. Téléchargez l'installateur EDB ou utilisez **Homebrew** :

```bash
brew install postgresql@16
brew services start postgresql@16
```

3. Définissez un mot de passe pour l'utilisateur `postgres` :

```bash
psql postgres
ALTER USER postgres WITH PASSWORD 'votre_mot_de_passe';
\q
```

### 🐧 Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

Définissez le mot de passe de l'utilisateur `postgres` :

```bash
sudo -u postgres psql
ALTER USER postgres WITH PASSWORD 'votre_mot_de_passe';
\q
```

---

## 2. Installation de pgAdmin4

> ℹ️ Sur **Windows**, pgAdmin4 est inclus dans l'installateur PostgreSQL. Vous pouvez passer cette étape si vous avez coché le composant lors de l'installation.

### 🪟 Windows (installation séparée)

1. Rendez-vous sur : [https://www.pgadmin.org/download/pgadmin-4-windows/](https://www.pgadmin.org/download/pgadmin-4-windows/)
2. Téléchargez le fichier `.exe` et lancez l'installateur
3. Suivez les étapes (installation par défaut)

### 🍎 macOS

1. Rendez-vous sur : [https://www.pgadmin.org/download/pgadmin-4-macos/](https://www.pgadmin.org/download/pgadmin-4-macos/)
2. Téléchargez le fichier `.dmg`, ouvrez-le et faites glisser pgAdmin4 dans Applications

### 🐧 Linux (Ubuntu/Debian)

```bash
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg

sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

sudo apt update
sudo apt install pgadmin4-desktop
```

---

## 3. Connexion au serveur PostgreSQL via pgAdmin4

1. Lancez **pgAdmin4**
2. Lors du premier lancement, définissez un **mot de passe maître** pour pgAdmin4
3. Dans le panneau gauche, faites un clic droit sur **Servers** → **Register** → **Server...**
4. Dans l'onglet **General** : donnez un nom au serveur (ex : `Local`)
5. Dans l'onglet **Connection** :
   - **Host** : `localhost`
   - **Port** : `5432`
   - **Maintenance database** : `postgres`
   - **Username** : `postgres`
   - **Password** : le mot de passe défini lors de l'installation
6. Cliquez sur **Save**

✅ Vous êtes maintenant connecté à votre serveur PostgreSQL.

---

## 4. Création de la base de données MSPR

### Via pgAdmin4 (interface graphique)

1. Dans le panneau gauche, dépliez votre serveur **Local**
2. Faites un clic droit sur **Databases** → **Create** → **Database...**
3. Dans le champ **Database** : saisissez `MSPR`
4. Laissez les autres options par défaut
5. Cliquez sur **Save**

### Via ligne de commande (alternative)

```bash
psql -U postgres -c "CREATE DATABASE MSPR;"
```

---

## 5. Exécution du script SQL

### Via pgAdmin4

1. Dans le panneau gauche, sélectionnez la base de données **MSPR**
2. Cliquez sur **Tools** dans la barre de menu → **Query Tool**
3. Dans l'éditeur qui s'ouvre, cliquez sur l'icône 📂 **Open File** (ou `Ctrl+O`)
4. Naviguez jusqu'au fichier `script_DB_MSPR_pg.sql` et ouvrez-le
5. Cliquez sur le bouton ▶️ **Execute/Refresh** (ou appuyez sur `F5`)
6. Vérifiez dans le panneau **Messages** que toutes les tables ont été créées sans erreur

### Via ligne de commande (alternative)

```bash
psql -U postgres -d MSPR -f /chemin/vers/script_DB_MSPR_pg.sql
```

Remplacez `/chemin/vers/` par le chemin réel vers votre fichier SQL.

---

## 6. Vérification

Pour vérifier que toutes les tables ont bien été créées :

1. Dans pgAdmin4, dépliez **MSPR** → **Schemas** → **public** → **Tables**
2. Vous devriez voir les tables suivantes :

| Table | Description |
|---|---|
| `user_` | Utilisateurs de l'application |
| `user_profile` | Profils et données physiques |
| `health_goal` | Objectifs de santé |
| `user_metrics` | Métriques de suivi (poids, steps, etc.) |
| `ingredients` | Base de données nutritionnelle |
| `recipe` | Recettes |
| `workout_session` | Sessions d'entraînement |
| `excercise` | Exercices physiques |
| `activity_type` | Types d'activités sportives |
| `connected_device` | Appareils connectés |
| `biometric_measure` | Mesures biométriques |
| `ai_recommendation` | Recommandations IA |
| `diet_recommendation` | Recommandations nutritionnelles |
| `subsrciption` | Abonnements |
| `fonctionnality` | Fonctionnalités disponibles |
| `payment_transaction` | Transactions de paiement |
| `data_source` | Sources de données externes |
| `etl_execution` | Exécutions ETL |
| `data_quality_check_` | Contrôles qualité des données |
| `data_anomaly` | Anomalies détectées |
| `society` | Sociétés/organisations |
| `history` | Historique utilisateur |

---

## 🛠️ Dépannage

**Erreur de connexion "password authentication failed"**
→ Vérifiez que le mot de passe saisi correspond bien à celui défini lors de l'installation de PostgreSQL.

**Port 5432 déjà utilisé**
→ Un autre service utilise ce port. Changez le port dans les paramètres de PostgreSQL (`postgresql.conf`) ou arrêtez le service concurrent.

**Le script SQL retourne des erreurs**
→ Assurez-vous d'avoir bien sélectionné la base **MSPR** avant d'exécuter le script. Vérifiez également que le script est exécuté en une seule fois (pas en plusieurs parties).

---

## 📚 Ressources utiles

- Documentation PostgreSQL : [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
- Documentation pgAdmin4 : [https://www.pgadmin.org/docs/](https://www.pgadmin.org/docs/)
