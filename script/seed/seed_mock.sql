-- ============================================================
-- HEALTHAI COACH — Données de test (seeds)
-- Fichier : 02_seeds.sql
-- ============================================================

-- ============================================================
-- HEALTH GOALS
-- ============================================================

INSERT INTO health_goal (goal_id, label, description) VALUES
('goal_1', 'Perte de poids',     'Réduire la masse graisseuse'),
('goal_2', 'Prise de muscle',    'Augmenter la masse musculaire'),
('goal_3', 'Endurance',          'Améliorer les capacités cardio'),
('goal_4', 'Bien-être général',  'Maintenir une hygiène de vie saine'),
('goal_5', 'Rééquilibrage',      'Équilibrer son alimentation');

-- ============================================================
-- ROLES
-- ============================================================

INSERT INTO role (role_id, role_type, is_system) VALUES
('role_freemium',   'FREEMIUM',     FALSE),
('role_premium',    'PREMIUM',      FALSE),
('role_premium_p',  'PREMIUM_PLUS', FALSE),
('role_b2b',        'B2B',          FALSE),
('role_admin',      'ADMIN',        TRUE),
('role_user',       'USER',         FALSE),
('role_nutri',      'NUTRITIONIST', TRUE),
('role_modo',       'MODERATOR',    TRUE);

-- ============================================================
-- PERMISSIONS
-- ============================================================

INSERT INTO permission (permission_id, permission_code, resource, action, description) VALUES
('perm_1',  'subscription:read',   'subscription',  'READ',   'Lire ses abonnements'),
('perm_2',  'subscription:create', 'subscription',  'CREATE', 'Créer un abonnement'),
('perm_3',  'user:read',           'user',          'READ',   'Lire les profils'),
('perm_4',  'user:delete',         'user',          'DELETE', 'Supprimer un utilisateur'),
('perm_5',  'user:admin',          'user',          'ADMIN',  'Administrer les utilisateurs'),
('perm_6',  'recipe:create',       'recipe',        'CREATE', 'Créer des recettes'),
('perm_7',  'analytics:read',      'analytics',     'READ',   'Accéder aux analytics'),
('perm_8',  'analytics:export',    'analytics',     'EXPORT', 'Exporter les données');

-- ============================================================
-- ASSOCIATION ROLE <-> PERMISSION
-- ============================================================

INSERT INTO has_permission (role_id, permission_id) VALUES
('role_admin',    'perm_1'),
('role_admin',    'perm_2'),
('role_admin',    'perm_3'),
('role_admin',    'perm_4'),
('role_admin',    'perm_5'),
('role_admin',    'perm_6'),
('role_admin',    'perm_7'),
('role_admin',    'perm_8'),
('role_premium',  'perm_1'),
('role_premium',  'perm_6'),
('role_premium',  'perm_7'),
('role_premium_p','perm_1'),
('role_premium_p','perm_6'),
('role_premium_p','perm_7'),
('role_premium_p','perm_8'),
('role_freemium', 'perm_1'),
('role_nutri',    'perm_3'),
('role_nutri',    'perm_6'),
('role_nutri',    'perm_7');

-- ============================================================
-- FEATURES
-- ============================================================

INSERT INTO feature (feature_id, name, description, category) VALUES
('feat_1',  'Recommandations IA',       'Suggestions personnalisées par IA',       'IA'),
('feat_2',  'Suivi nutritionnel',        'Suivi détaillé des repas et calories',    'NUTRITION'),
('feat_3',  'Programmes fitness',        'Programmes d''entraînement guidés',       'FITNESS'),
('feat_4',  'Synchronisation appareils', 'Sync avec montres et capteurs',           'INTEGRATION'),
('feat_5',  'Analytics avancés',         'Tableaux de bord et statistiques',        'ANALYTICS'),
('feat_6',  'Export données',            'Export PDF/CSV des données',              'ANALYTICS'),
('feat_7',  'Gestion équipe B2B',        'Administration des membres organisation', 'ADMIN'),
('feat_8',  'Recettes illimitées',       'Accès à toutes les recettes',             'NUTRITION'),
('feat_9',  'Suivi sommeil',             'Analyse de la qualité du sommeil',        'FITNESS'),
('feat_10', 'Coaching en ligne',         'Accès aux nutritionnistes',               'SOCIAL');

-- ============================================================
-- SUBSCRIPTION PLANS
-- ============================================================

INSERT INTO subscription_plan (plan_id, name, description, billing_cycle, price_ht, is_public, created_at, updated_at, role_id) VALUES
('plan_free',    'Freemium',      'Accès gratuit aux fonctionnalités de base',           'MONTHLY', 0.00,   TRUE, NOW(), NOW(), 'role_freemium'),
('plan_prem',    'Premium',       'Accès complet aux fonctionnalités fitness et nutrition', 'MONTHLY', 9.99,  TRUE, NOW(), NOW(), 'role_premium'),
('plan_prem_y',  'Premium Annuel','Premium avec facturation annuelle',                   'ANNUAL',  99.00,  TRUE, NOW(), NOW(), 'role_premium'),
('plan_plus',    'Premium Plus',  'Toutes les fonctionnalités + coaching',               'MONTHLY', 19.99,  TRUE, NOW(), NOW(), 'role_premium_p'),
('plan_b2b',     'B2B',           'Licence entreprise multi-utilisateurs',               'ANNUAL',  299.00, FALSE, NOW(), NOW(), 'role_b2b');

-- ============================================================
-- ASSOCIATION PLAN <-> FEATURE
-- ============================================================

INSERT INTO has_feature (plan_id, feature_id) VALUES
('plan_free',   'feat_2'),
('plan_free',   'feat_3'),
('plan_prem',   'feat_1'),
('plan_prem',   'feat_2'),
('plan_prem',   'feat_3'),
('plan_prem',   'feat_4'),
('plan_prem',   'feat_5'),
('plan_prem',   'feat_8'),
('plan_prem',   'feat_9'),
('plan_prem_y', 'feat_1'),
('plan_prem_y', 'feat_2'),
('plan_prem_y', 'feat_3'),
('plan_prem_y', 'feat_4'),
('plan_prem_y', 'feat_5'),
('plan_prem_y', 'feat_8'),
('plan_prem_y', 'feat_9'),
('plan_plus',   'feat_1'),
('plan_plus',   'feat_2'),
('plan_plus',   'feat_3'),
('plan_plus',   'feat_4'),
('plan_plus',   'feat_5'),
('plan_plus',   'feat_6'),
('plan_plus',   'feat_8'),
('plan_plus',   'feat_9'),
('plan_plus',   'feat_10'),
('plan_b2b',    'feat_1'),
('plan_b2b',    'feat_2'),
('plan_b2b',    'feat_3'),
('plan_b2b',    'feat_4'),
('plan_b2b',    'feat_5'),
('plan_b2b',    'feat_6'),
('plan_b2b',    'feat_7'),
('plan_b2b',    'feat_8'),
('plan_b2b',    'feat_9'),
('plan_b2b',    'feat_10');

-- ============================================================
-- ORGANISATIONS B2B
-- ============================================================

INSERT INTO organization (organization_id, name, org_type, domain) VALUES
('org_1', 'FitCorp SAS',        'COMPANY', 'fitcorp.fr'),
('org_2', 'MusclePark Lyon',    'GYM',     'musclepark-lyon.fr'),
('org_3', 'Mutuelle SantéPlus', 'MUTUAL',  'santeplus.fr');

INSERT INTO org_subscription (org_sub_id, seats_total, seats_used, status, start_date, end_date, plan_id, organization_id) VALUES
('orgsub_1', 50,  12, 'ACTIVE',   '2025-01-01', '2026-01-01', 'plan_b2b', 'org_1'),
('orgsub_2', 20,  8,  'ACTIVE',   '2025-03-01', '2026-03-01', 'plan_b2b', 'org_2'),
('orgsub_3', 100, 0,  'SUSPENDED','2024-06-01', '2025-06-01', 'plan_b2b', 'org_3');

-- ============================================================
-- USER PROFILES
-- ============================================================

INSERT INTO user_profile (profile_id, height_cm, current_weight_kg, activity_level_ref, allergies_json, preferences_json, updated_at, goal_id) VALUES
('prof_1', 178, 82.50, 'MODERATE',    '["gluten"]',              '{"theme":"dark"}',  NOW(), 'goal_1'),
('prof_2', 165, 61.00, 'ACTIVE',      '[]',                      '{"theme":"light"}', NOW(), 'goal_3'),
('prof_3', 182, 95.00, 'SEDENTARY',   '["lactose","arachides"]', '{"theme":"dark"}',  NOW(), 'goal_2'),
('prof_4', 170, 58.00, 'VERY_ACTIVE', '[]',                      '{"theme":"light"}', NOW(), 'goal_4'),
('prof_5', 175, 74.00, 'MODERATE',    '["gluten"]',              '{"theme":"dark"}',  NOW(), 'goal_5'),
('prof_6', 168, 67.50, 'ACTIVE',      '[]',                      '{"theme":"light"}', NOW(), 'goal_1'),
('prof_7', 180, 88.00, 'MODERATE',    '[]',                      '{"theme":"dark"}',  NOW(), 'goal_2');

-- ============================================================
-- UTILISATEURS
-- ============================================================

INSERT INTO user_ (user_id, email, password_hash, first_name, last_name, birth_date, gender_code, created_at, is_active, role_id, profile_id) VALUES
('user_1', 'alice.martin@email.fr',   '$2b$12$hashed_password_1', 'Alice',   'Martin',   '1995-04-12', 1, NOW(), TRUE,  'role_premium',  'prof_1'),
('user_2', 'bob.dupont@email.fr',     '$2b$12$hashed_password_2', 'Bob',     'Dupont',   '1988-09-23', 2, NOW(), TRUE,  'role_freemium', 'prof_2'),
('user_3', 'carla.russo@email.fr',    '$2b$12$hashed_password_3', 'Carla',   'Russo',    '2000-01-15', 1, NOW(), TRUE,  'role_premium_p','prof_3'),
('user_4', 'david.leroy@email.fr',    '$2b$12$hashed_password_4', 'David',   'Leroy',    '1992-07-30', 2, NOW(), TRUE,  'role_b2b',      'prof_4'),
('user_5', 'emma.bernard@email.fr',   '$2b$12$hashed_password_5', 'Emma',    'Bernard',  '1997-11-08', 1, NOW(), FALSE, 'role_freemium', 'prof_5'),
('user_6', 'admin@healthai.fr',       '$2b$12$hashed_password_6', 'Admin',   'HealthAI', '1990-01-01', 2, NOW(), TRUE,  'role_admin',    'prof_6'),
('user_7', 'lucas.moreau@email.fr',   '$2b$12$hashed_password_7', 'Lucas',   'Moreau',   '1985-03-22', 2, NOW(), TRUE,  'role_premium',  'prof_7');

-- ============================================================
-- ASSOCIATION USER <-> ORGANISATION
-- ============================================================

INSERT INTO Parts_of (user_id, organization_id) VALUES
('user_4', 'org_1'),
('user_7', 'org_2');

-- ============================================================
-- ABONNEMENTS
-- ============================================================

INSERT INTO subscription (subscription_id, start_date, end_date, status, cancelled_at, cancellation_reason, created_at, updated_at, user_id, plan_id) VALUES
('sub_1', '2025-01-01', '2026-01-01', 'ACTIVE',    NULL,         NULL,              NOW(), NOW(), 'user_1', 'plan_prem_y'),
('sub_2', '2025-03-01', NULL,         'ACTIVE',    NULL,         NULL,              NOW(), NOW(), 'user_2', 'plan_free'),
('sub_3', '2024-11-01', '2025-11-01', 'ACTIVE',    NULL,         NULL,              NOW(), NOW(), 'user_3', 'plan_plus'),
('sub_4', '2025-01-01', '2026-01-01', 'ACTIVE',    NULL,         NULL,              NOW(), NOW(), 'user_4', 'plan_b2b'),
('sub_5', '2024-06-01', '2024-12-01', 'CANCELLED', '2024-09-15', 'USER_REQUEST',    NOW(), NOW(), 'user_5', 'plan_prem'),
('sub_6', '2025-02-01', NULL,         'ACTIVE',    NULL,         NULL,              NOW(), NOW(), 'user_7', 'plan_prem');

-- ============================================================
-- HISTORIQUE DES ABONNEMENTS
-- ============================================================

INSERT INTO subscription_history (history_id, event_type, previous_role, new_role, occurred_at, previous_plan_id, new_plan_id, user_id, subscription_id) VALUES
('hist_1', 'CREATED',    NULL,        'PREMIUM',      '2025-01-01 10:00:00', NULL,         'plan_prem_y', 'user_1', 'sub_1'),
('hist_2', 'CREATED',    NULL,        'FREEMIUM',     '2025-03-01 09:00:00', NULL,         'plan_free',   'user_2', 'sub_2'),
('hist_3', 'UPGRADED',   'PREMIUM',   'PREMIUM_PLUS', '2024-11-01 14:30:00', 'plan_prem',  'plan_plus',   'user_3', 'sub_3'),
('hist_4', 'CREATED',    NULL,        'B2B',          '2025-01-01 08:00:00', NULL,         'plan_b2b',    'user_4', 'sub_4'),
('hist_5', 'CANCELLED',  'PREMIUM',   NULL,           '2024-09-15 16:00:00', 'plan_prem',  NULL,          'user_5', 'sub_5'),
('hist_6', 'CREATED',    NULL,        'PREMIUM',      '2025-02-01 11:00:00', NULL,         'plan_prem',   'user_7', 'sub_6');

-- ============================================================
-- TRANSACTIONS DE PAIEMENT
-- ============================================================

INSERT INTO payment_transaction (transaction_id, processed_at, amount_ht, status, created_at, subscription_id) VALUES
('tx_1', '2025-01-01 10:05:00', 99.00,  'SUCCEEDED', NOW(), 'sub_1'),
('tx_2', '2024-11-01 14:35:00', 19.99,  'SUCCEEDED', NOW(), 'sub_3'),
('tx_3', '2024-12-01 14:35:00', 19.99,  'SUCCEEDED', NOW(), 'sub_3'),
('tx_4', '2025-01-01 08:05:00', 299.00, 'SUCCEEDED', NOW(), 'sub_4'),
('tx_5', '2024-06-01 09:00:00', 9.99,   'SUCCEEDED', NOW(), 'sub_5'),
('tx_6', '2024-07-01 09:00:00', 9.99,   'FAILED',    NOW(), 'sub_5'),
('tx_7', '2025-02-01 11:05:00', 9.99,   'SUCCEEDED', NOW(), 'sub_6');

-- ============================================================
-- INGREDIENTS
-- ============================================================

INSERT INTO ingredients (ingredients_id, name, brand, calories_100g, fat_100g, nutriscore, category_ref, fiber_g, sugar_g, sodium_mg, cholesterol_mg, protein_100g, carbs_100g) VALUES
('ing_1',  'Poulet (blanc)',     NULL,         110.00, 2.50,  1, 'VIANDE',   0.00, 0.00, 70.00,  85.00, 23.00, 0.00),
('ing_2',  'Riz complet',        NULL,         350.00, 2.70,  2, 'FECULENTS',3.50, 0.50, 5.00,   0.00,  7.50,  73.00),
('ing_3',  'Brocoli',            NULL,         34.00,  0.40,  1, 'LEGUMES',  2.60, 1.70, 33.00,  0.00,  2.80,  6.60),
('ing_4',  'Avocat',             NULL,         160.00, 14.70, 1, 'FRUITS',   6.70, 0.70, 7.00,   0.00,  2.00,  8.50),
('ing_5',  'Œuf entier',         NULL,         155.00, 11.00, 3, 'PROTEINES',0.00, 1.10, 124.00, 373.00,13.00, 1.10),
('ing_6',  'Saumon',             NULL,         208.00, 13.00, 1, 'POISSON',  0.00, 0.00, 59.00,  63.00, 22.00, 0.00),
('ing_7',  'Avoine',             'Quaker',     389.00, 6.90,  1, 'FECULENTS',10.60,1.10, 2.00,   0.00,  17.00, 66.00),
('ing_8',  'Yaourt grec nature', 'Fage',       97.00,  5.00,  2, 'LAITIER',  0.00, 3.20, 47.00,  15.00, 9.00,  3.60),
('ing_9',  'Banane',             NULL,         89.00,  0.30,  3, 'FRUITS',   2.60, 12.20,1.00,   0.00,  1.10,  22.80),
('ing_10', 'Amandes',            NULL,         579.00, 49.90, 1, 'OLEAGINEUX',12.50,4.35,1.00,   0.00,  21.20, 21.60);

-- ============================================================
-- RECETTES
-- ============================================================

INSERT INTO recipe (recipe_id, title, instructions, prep_time_min, difficulty, created_by_user_id) VALUES
('rec_1', 'Bowl poulet riz',     'Cuire le riz. Griller le poulet. Assembler avec brocoli vapeur.',  25, 2, FALSE),
('rec_2', 'Omelette protéinée',  'Battre 3 œufs. Ajouter légumes. Cuire 5 min à feu moyen.',         10, 1, FALSE),
('rec_3', 'Porridge avoine',     'Chauffer l''avoine avec lait. Ajouter banane et amandes.',          8,  1, FALSE),
('rec_4', 'Saumon avocat',       'Pocher le saumon. Servir avec avocat tranché et citron.',           15, 2, TRUE);

INSERT INTO recipe_ingredients (ingredients_id, recipe_id, quantity) VALUES
('ing_1', 'rec_1', 150),
('ing_2', 'rec_1', 100),
('ing_3', 'rec_1', 80),
('ing_5', 'rec_2', 180),
('ing_7', 'rec_3', 80),
('ing_9', 'rec_3', 100),
('ing_10','rec_3', 15),
('ing_6', 'rec_4', 180),
('ing_4', 'rec_4', 100);

-- ============================================================
-- ACTIVITY TYPES
-- ============================================================

INSERT INTO activity_type (activity_id, name, met_value, icon_url) VALUES
('act_1', 'Course à pied',   8,  '/icons/running.svg'),
('act_2', 'Vélo',            6,  '/icons/cycling.svg'),
('act_3', 'Musculation',     5,  '/icons/weights.svg'),
('act_4', 'Natation',        7,  '/icons/swimming.svg'),
('act_5', 'Yoga',            3,  '/icons/yoga.svg'),
('act_6', 'HIIT',            10, '/icons/hiit.svg');

-- ============================================================
-- EXERCICES
-- ============================================================

INSERT INTO exercise (exercise_id, name, body_part_target, video_url, description, difficulty_level, equipment_required, category) VALUES
('ex_1',  'Squat',           'Jambes',   '/videos/squat.mp4',     'Flexion des genoux, dos droit',         2, 'Aucun',    'FORCE'),
('ex_2',  'Pompes',          'Pectoraux','/videos/pushup.mp4',    'Corps aligné, coudes à 45 degrés',      1, 'Aucun',    'FORCE'),
('ex_3',  'Tractions',       'Dos',      '/videos/pullup.mp4',    'Barre fixe, tirage menton au-dessus',   3, 'Barre',    'FORCE'),
('ex_4',  'Soulevé de terre','Dos/Jambes','/videos/deadlift.mp4', 'Dos plat, charge au sol',               4, 'Haltères', 'FORCE'),
('ex_5',  'Planche',         'Core',     '/videos/plank.mp4',     'Corps aligné, abdos contractés',        1, 'Aucun',    'GAINAGE'),
('ex_6',  'Burpee',          'Full body', '/videos/burpee.mp4',   'Pompe + saut vertical',                 3, 'Aucun',    'CARDIO'),
('ex_7',  'Fente',           'Jambes',   '/videos/lunge.mp4',     'Pas en avant, genou à 90 degrés',       2, 'Aucun',    'FORCE'),
('ex_8',  'Curl biceps',     'Bras',     '/videos/curl.mp4',      'Coude fixe, flexion avant-bras',        1, 'Haltères', 'FORCE');

-- ============================================================
-- CONNECTED DEVICES
-- ============================================================

INSERT INTO connected_device (device_id, device_name, device_type, last_synch, is_active) VALUES
('dev_1', 'Apple Watch S9',     'SMARTWATCH', '2026-03-07', TRUE),
('dev_2', 'Garmin Forerunner',  'SMARTWATCH', '2026-03-06', TRUE),
('dev_3', 'Fitbit Charge 5',    'BRACELET',   '2026-02-28', FALSE),
('dev_4', 'Polar H10',          'CARDIOMETRE','2026-03-07', TRUE),
('dev_5', 'Withings Scale',     'BALANCE',    '2026-03-05', TRUE);

INSERT INTO pairs (user_id, device_id) VALUES
('user_1', 'dev_1'),
('user_1', 'dev_5'),
('user_3', 'dev_2'),
('user_4', 'dev_4'),
('user_7', 'dev_3');

-- ============================================================
-- USER METRICS
-- ============================================================

INSERT INTO user_metrics (metric_id, recorded_date, weight_kg, body_fat_pourcentage, steps, calories_burned, heart_rate_avg, heart_rate_max, sleep_hours, created_at) VALUES
('met_1',  '2026-03-01', 82.50, 18, 9823,  520.00, 68, 142, 7,  NOW()),
('met_2',  '2026-03-02', 82.20, 18, 12045, 610.00, 70, 155, 8,  NOW()),
('met_3',  '2026-03-03', 82.00, 17, 7500,  480.00, 67, 138, 6,  NOW()),
('met_4',  '2026-03-04', 81.80, 17, 11200, 590.00, 69, 148, 7,  NOW()),
('met_5',  '2026-03-01', 61.00, 22, 8900,  420.00, 72, 160, 8,  NOW()),
('met_6',  '2026-03-02', 60.80, 22, 15000, 680.00, 75, 175, 7,  NOW()),
('met_7',  '2026-03-01', 95.00, 28, 4200,  380.00, 78, 145, 6,  NOW()),
('met_8',  '2026-03-02', 94.50, 27, 6800,  450.00, 76, 150, 7,  NOW());

INSERT INTO gets (goal_id, metric_id) VALUES
('goal_1', 'met_1'),
('goal_1', 'met_2'),
('goal_1', 'met_3'),
('goal_1', 'met_4'),
('goal_3', 'met_5'),
('goal_3', 'met_6'),
('goal_2', 'met_7'),
('goal_2', 'met_8');

-- ============================================================
-- BIOMETRIC MEASURES
-- ============================================================

INSERT INTO biometric_measure (measure_id, type, value_, measured_at, user_id) VALUES
('bio_1', 'HEART_RATE',    72,  '2026-03-07 08:00:00', 'user_1'),
('bio_2', 'BLOOD_PRESSURE',120, '2026-03-07 08:01:00', 'user_1'),
('bio_3', 'HEART_RATE',    68,  '2026-03-06 07:30:00', 'user_3'),
('bio_4', 'HEART_RATE',    85,  '2026-03-07 09:00:00', 'user_4'),
('bio_5', 'SPO2',          98,  '2026-03-07 08:00:00', 'user_7'),
('bio_6', 'HEART_RATE',    74,  '2026-03-07 08:00:00', 'user_7');

INSERT INTO records (device_id, measure_id) VALUES
('dev_1', 'bio_1'),
('dev_1', 'bio_2'),
('dev_2', 'bio_3'),
('dev_4', 'bio_4'),
('dev_1', 'bio_5'),
('dev_1', 'bio_6');

-- ============================================================
-- WORKOUT SESSIONS
-- ============================================================

INSERT INTO workout_session (session_id, start_time, duration_time, calories_burned, notes, distance_km, activity_id, user_id) VALUES
('ses_1', '2026-03-06 07:00:00', 45,  380, 'Bonne séance jambes',       NULL, 'act_3', 'user_1'),
('ses_2', '2026-03-05 18:30:00', 60,  520, 'Run facile bord de rivière',8.50, 'act_1', 'user_1'),
('ses_3', '2026-03-07 06:30:00', 50,  420, 'HIIT du matin',             NULL, 'act_6', 'user_3'),
('ses_4', '2026-03-06 12:00:00', 30,  200, 'Yoga pauses déjeuner',      NULL, 'act_5', 'user_4'),
('ses_5', '2026-03-07 17:00:00', 55,  450, 'Musculation full body',     NULL, 'act_3', 'user_7');

INSERT INTO session_detail (detail_id, sets, reps, weight_kg, exercise_id, session_id) VALUES
('sd_1',  4, 10, 80.00,  'ex_4', 'ses_1'),
('sd_2',  3, 12, 60.00,  'ex_1', 'ses_1'),
('sd_3',  3, 15, 0.00,   'ex_7', 'ses_1'),
('sd_4',  4, 8,  0.00,   'ex_6', 'ses_3'),
('sd_5',  3, 30, 0.00,   'ex_5', 'ses_3'),
('sd_6',  4, 10, 50.00,  'ex_4', 'ses_5'),
('sd_7',  3, 12, 0.00,   'ex_2', 'ses_5'),
('sd_8',  3, 10, 15.00,  'ex_8', 'ses_5');

-- ============================================================
-- INGREDIENTS ATE
-- ============================================================

INSERT INTO ingredients_ate (entry_id, consumed_at, quantity_grams, meal_type, calories_consumed, user_id) VALUES
('eat_1', '2026-03-07', 150, TRUE,  165, 'user_1'),
('eat_2', '2026-03-07', 100, TRUE,  350, 'user_1'),
('eat_3', '2026-03-07', 180, FALSE, 198, 'user_3'),
('eat_4', '2026-03-07', 200, TRUE,  178, 'user_3'),
('eat_5', '2026-03-07', 100, FALSE, 160, 'user_7'),
('eat_6', '2026-03-07', 80,  TRUE,  311, 'user_7');

INSERT INTO consumes (ingredients_id, entry_id, quantity) VALUES
('ing_1', 'eat_1', 150),
('ing_2', 'eat_2', 100),
('ing_6', 'eat_3', 180),
('ing_3', 'eat_4', 200),
('ing_4', 'eat_5', 100),
('ing_7', 'eat_6', 80);

-- ============================================================
-- AI RECOMMENDATIONS
-- ============================================================

INSERT INTO ai_recommendation (recommendation_id, generated_at, category, title, content_text, confidence_score, is_viewed, feedback_rating, user_id) VALUES
('reco_1', '2026-03-07 08:00:00', 'NUTRITION', 'Augmente tes protéines',
 'Ton objectif de perte de poids nécessite un apport protéique plus élevé. Vise 1.8g par kg de poids corporel.',
 0.92, TRUE,  4.50, 'user_1'),
('reco_2', '2026-03-07 08:00:00', 'FITNESS',   'Repos recommandé',
 'Tu as enchaîné 4 séances cette semaine. Une journée de récupération active est conseillée aujourd''hui.',
 0.88, FALSE, NULL, 'user_1'),
('reco_3', '2026-03-06 09:00:00', 'NUTRITION', 'Hydratation insuffisante',
 'Tes données montrent une hydratation en dessous des recommandations. Vise 2.5L d''eau par jour.',
 0.85, TRUE,  5.00, 'user_3'),
('reco_4', '2026-03-07 07:00:00', 'FITNESS',   'Progression squat',
 'Tu es prêt à augmenter la charge sur tes squats. Essaie +5kg la prochaine séance.',
 0.90, FALSE, NULL, 'user_7');

-- ============================================================
-- DIET RECOMMENDATIONS
-- ============================================================

INSERT INTO diet_recommendation (recommendation_id, meal_type, recommended_foods, total_calories, protein_g, carbs_g, fat_g, diet_type, generated_at, is_followed, user_id) VALUES
('diet_1', 'Petit-déjeuner', 'Porridge avoine, banane, amandes, café noir',         420, 15, 65, 12, 'Équilibré',   '2026-03-07 07:00:00', TRUE,  'user_1'),
('diet_2', 'Déjeuner',       'Bowl poulet riz brocoli, eau citronnée',              520, 40, 55, 10, 'Équilibré',   '2026-03-07 12:00:00', TRUE,  'user_1'),
('diet_3', 'Dîner',          'Saumon avocat, salade verte, yaourt grec',            480, 38, 20, 28, 'Protéiné',    '2026-03-07 19:00:00', FALSE, 'user_1'),
('diet_4', 'Petit-déjeuner', 'Omelette 3 œufs, épinards, café',                   310, 22, 5,  20, 'Low-carb',    '2026-03-07 07:00:00', TRUE,  'user_3'),
('diet_5', 'Déjeuner',       'Saumon grillé, quinoa, légumes rôtis',               550, 42, 45, 15, 'Protéiné',    '2026-03-07 12:00:00', TRUE,  'user_3');

-- ============================================================
-- DATA SOURCES (ETL)
-- ============================================================

INSERT INTO data_source (source_id, source_name, source_type, format, source_url, expected_records, last_updates, is_active) VALUES
('src_1', 'OpenFoodFacts',    'API_REST', 'JSON', 'https://world.openfoodfacts.org/api/v2', '500000', NOW(), TRUE),
('src_2', 'Strava API',       'API_REST', 'JSON', 'https://www.strava.com/api/v3',          '10000',  NOW(), TRUE),
('src_3', 'Garmin Health',    'API_REST', 'JSON', 'https://healthapi.garmin.com',            '5000',   NOW(), TRUE),
('src_4', 'CSV Nutritionnel', 'CSV',      'CSV',  '/imports/nutrition_data.csv',             '2000',   NOW(), FALSE);

INSERT INTO links (user_id, source_id) VALUES
('user_1', 'src_2'),
('user_1', 'src_3'),
('user_3', 'src_2'),
('user_4', 'src_3'),
('user_6', 'src_1');

-- ============================================================
-- ETL EXECUTIONS
-- ============================================================

INSERT INTO etl_execution (execution_id, started_at, ended_at, status, records_extracted, records_loaded, records_rejected, error_message, triggered_by, source_id) VALUES
('etl_1', '2026-03-07 02:00:00', '2026-03-07 02:45:00', TRUE,  4823, 4801, 22,   NULL,                        'SCHEDULER', 'src_1'),
('etl_2', '2026-03-07 03:00:00', '2026-03-07 03:10:00', TRUE,  312,  312,  0,    NULL,                        'SCHEDULER', 'src_2'),
('etl_3', '2026-03-06 02:00:00', '2026-03-06 02:30:00', FALSE, 1200, 0,    1200, 'Timeout connexion Garmin',  'SCHEDULER', 'src_3'),
('etl_4', '2026-03-05 10:00:00', '2026-03-05 10:05:00', TRUE,  2000, 1987, 13,   NULL,                        'MANUAL',    'src_4');

INSERT INTO data_quality_check_ (check_id, target_table, check_type, check_rule, records_checked, records_failed, checked_at, status, execution_id) VALUES
('chk_1', 'ingredients',   'NULL_CHECK',      'calories_100g IS NOT NULL', '4823', '12',  '2026-03-07 02:46:00', TRUE,  'etl_1'),
('chk_2', 'ingredients',   'RANGE_CHECK',     'calories_100g BETWEEN 0 AND 900', '4823', '3', '2026-03-07 02:46:00', TRUE, 'etl_1'),
('chk_3', 'workout_session','NULL_CHECK',      'session_id IS NOT NULL',    '312',  '0',   '2026-03-07 03:11:00', TRUE,  'etl_2'),
('chk_4', 'user_metrics',   'RANGE_CHECK',     'weight_kg BETWEEN 20 AND 300', '2000', '13', '2026-03-05 10:06:00', TRUE, 'etl_4');

INSERT INTO data_anomaly (anomaly_id, source_table, anomaly_table, field_name, record_identifier, original_value, detected_at, severity, is_resolved, resolution_action, check_id, execution_id) VALUES
('ano_1', 'openfoodfacts', 'ingredients', 'calories_100g', 'OFF-123456', '950',   '2026-03-07 02:47:00', 'HIGH',   FALSE, NULL,              'chk_1', 'etl_1'),
('ano_2', 'openfoodfacts', 'ingredients', 'name',          'OFF-789012', NULL,    '2026-03-07 02:47:00', 'MEDIUM', TRUE,  'Valeur ignorée',  'chk_1', 'etl_1'),
('ano_3', 'nutrition_csv', 'user_metrics','weight_kg',     'ROW-0042',   '-5.00', '2026-03-05 10:07:00', 'HIGH',   TRUE,  'Ligne supprimée', 'chk_4', 'etl_4');