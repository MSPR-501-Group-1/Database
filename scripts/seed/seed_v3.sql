-- ============================================================
-- SEED PostgreSQL
-- ============================================================

-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- ENUMS (already created in schema, listed here for reference)
-- ============================================================

-- ============================================================
-- health_goal
-- ============================================================
INSERT INTO health_goal (goal_id, label, description) VALUES
  ('GOAL_001', 'Weight Loss',        'Reduce body weight through balanced diet and exercise'),
  ('GOAL_002', 'Muscle Gain',        'Increase lean muscle mass through strength training'),
  ('GOAL_003', 'Endurance',          'Improve cardiovascular endurance and stamina'),
  ('GOAL_004', 'Flexibility',        'Enhance range of motion and reduce injury risk'),
  ('GOAL_005', 'General Wellness',   'Maintain overall health and well-being');

-- ============================================================
-- ingredients
-- ============================================================
INSERT INTO ingredients (ingredients_id, name, calories_g, fat_g, nutriscore, category, fiber_g, sugar_g, sodium_mg, cholesterol_mg, protein_g, carbs_g) VALUES
  ('ING_001', 'Chicken Breast',  1.65, 0.36, 'A', 'MEAT',      0.0,  0.0,  74.0,  85.0,  31.0,  0.0),
  ('ING_002', 'Broccoli',        0.34, 0.04, 'A', 'VEGETABLE', 2.6,  0.7,  33.0,   0.0,   2.8,  7.0),
  ('ING_003', 'Brown Rice',      1.11, 0.09, 'B', 'GRAIN',     1.8,  0.4,   5.0,   0.0,   2.6, 23.0),
  ('ING_004', 'Whole Milk',      0.61, 0.33, 'C', 'DAIRY',     0.0,  4.8,  44.0,  10.0,   3.2,  4.8),
  ('ING_005', 'Banana',          0.89, 0.03, 'A', 'FRUIT',     2.6, 12.2,   1.0,   0.0,   1.1, 23.0),
  ('ING_006', 'Salmon',          2.08, 1.30, 'A', 'MEAT',      0.0,  0.0,  59.0,  63.0,  20.0,  0.0),
  ('ING_007', 'Olive Oil',       8.84, 10.0, 'D', 'OTHER',     0.0,  0.0,   0.0,   0.0,   0.0,  0.0),
  ('ING_008', 'Oats',            3.89, 0.67, 'A', 'GRAIN',    10.6,  0.0,   2.0,   0.0,  16.9, 66.0),
  ('ING_009', 'Greek Yogurt',    0.59, 0.04, 'A', 'DAIRY',     0.0,  3.2,  36.0,   5.0,  10.0,  3.6),
  ('ING_010', 'Spinach',         0.23, 0.04, 'A', 'VEGETABLE', 2.2,  0.4,  79.0,   0.0,   2.9,  3.6);

-- ============================================================
-- recipe
-- ============================================================
INSERT INTO recipe (recipe_id, title, instructions, prep_time_min, difficulty) VALUES
  ('RCP_001', 'Grilled Chicken & Broccoli',
   'Season chicken with salt and pepper. Grill 6 min each side. Steam broccoli 5 min. Serve together.',
   20, 'EASY'),
  ('RCP_002', 'Salmon Rice Bowl',
   'Cook brown rice. Pan-sear salmon 4 min each side with olive oil. Serve over rice with spinach.',
   30, 'MEDIUM'),
  ('RCP_003', 'Overnight Oats',
   'Mix oats with milk and yogurt. Add banana slices. Refrigerate overnight. Serve cold.',
   10, 'EASY'),
  ('RCP_004', 'Spinach Omelette',
   'Beat 3 eggs. Cook spinach in olive oil 2 min. Pour eggs over, fold when set.',
   15, 'EASY'),
  ('RCP_005', 'Protein Power Bowl',
   'Cook brown rice. Grill chicken breast. Sauté broccoli and spinach. Assemble bowl, drizzle olive oil.',
   35, 'MEDIUM');

-- ============================================================
-- recipe_ingredients
-- ============================================================
INSERT INTO recipe_ingredients (ingredients_id, recipe_id, quantity) VALUES
  ('ING_001', 'RCP_001', 200),
  ('ING_002', 'RCP_001', 150),
  ('ING_006', 'RCP_002', 180),
  ('ING_003', 'RCP_002', 100),
  ('ING_010', 'RCP_002',  50),
  ('ING_007', 'RCP_002',  10),
  ('ING_008', 'RCP_003', 80),
  ('ING_004', 'RCP_003', 120),
  ('ING_009', 'RCP_003', 100),
  ('ING_005', 'RCP_003',  80),
  ('ING_010', 'RCP_004', 100),
  ('ING_007', 'RCP_004',  10),
  ('ING_001', 'RCP_005', 200),
  ('ING_003', 'RCP_005', 100),
  ('ING_002', 'RCP_005', 100),
  ('ING_010', 'RCP_005',  50),
  ('ING_007', 'RCP_005',  15);

-- ============================================================
-- exercise
-- ============================================================
INSERT INTO exercise (exercise_id, name, body_part_target, video_url, description, difficulty_level, equipment_required, category) VALUES
  ('EXC_001', 'Push-Up',         'CHEST',       'https://videos.example.com/pushup',      'Classic bodyweight chest exercise',          'BEGINNER',     'None',         'STRENGTH'),
  ('EXC_002', 'Squat',           'LEGS',        'https://videos.example.com/squat',       'Fundamental lower body strength move',       'BEGINNER',     'None',         'STRENGTH'),
  ('EXC_003', 'Deadlift',        'BACK',        'https://videos.example.com/deadlift',    'Compound posterior chain exercise',          'INTERMEDIATE', 'Barbell',      'STRENGTH'),
  ('EXC_004', 'Running',         'FULL_BODY',   'https://videos.example.com/running',     'Steady-state cardio session',                'BEGINNER',     'Shoes',        'CARDIO'),
  ('EXC_005', 'Plank',           'CORE',        'https://videos.example.com/plank',       'Isometric core stability hold',              'BEGINNER',     'None',         'BALANCE'),
  ('EXC_006', 'Pull-Up',         'BACK',        'https://videos.example.com/pullup',      'Vertical pulling bodyweight movement',       'INTERMEDIATE', 'Pull-up bar',  'STRENGTH'),
  ('EXC_007', 'Yoga Flow',       'FULL_BODY',   'https://videos.example.com/yoga',        'Dynamic flexibility and breathing sequence', 'BEGINNER',     'Yoga mat',     'FLEXIBILITY'),
  ('EXC_008', 'Burpee',          'FULL_BODY',   'https://videos.example.com/burpee',      'High-intensity full body conditioning',      'INTERMEDIATE', 'None',         'CARDIO'),
  ('EXC_009', 'Bench Press',     'CHEST',       'https://videos.example.com/benchpress',  'Horizontal pressing strength exercise',      'INTERMEDIATE', 'Barbell+Bench','STRENGTH'),
  ('EXC_010', 'Jump Rope',       'FULL_BODY',   'https://videos.example.com/jumprope',    'High-intensity cardiovascular drill',        'BEGINNER',     'Jump rope',    'CARDIO');

-- ============================================================
-- connected_device
-- ============================================================
INSERT INTO connected_device (device_id, device_name, device_type, last_synch, is_active) VALUES
  ('DEV_001', 'Apple Watch Series 9',  'Smartwatch',     '2025-01-14', TRUE),
  ('DEV_002', 'Garmin Forerunner 955', 'GPS Watch',      '2025-01-13', TRUE),
  ('DEV_003', 'Withings Body+',        'Smart Scale',    '2025-01-12', TRUE),
  ('DEV_004', 'Fitbit Charge 6',       'Fitness Tracker','2025-01-10', FALSE),
  ('DEV_005', 'Polar H10',             'Heart Rate Belt','2025-01-14', TRUE);

-- ============================================================
-- user_metrics
-- ============================================================
INSERT INTO user_metrics (metric_id, recorded_date, weight_kg, body_fat_pourcentage, steps, calories_burned, heart_rate_avg, heart_rate_max, sleep_hours) VALUES
  ('MET_001', '2025-01-01 07:00:00', 78.50, 18.5, 9200,  520.0, 68, 145, 7),
  ('MET_002', '2025-01-02 07:00:00', 78.30, 18.4, 11500, 610.0, 70, 162, 8),
  ('MET_003', '2025-01-03 07:00:00', 78.10, 18.3, 7800,  480.0, 67, 138, 6),
  ('MET_004', '2025-01-01 07:00:00', 62.00, 22.1, 8500,  420.0, 72, 155, 7),
  ('MET_005', '2025-01-02 07:00:00', 61.80, 22.0, 10200, 510.0, 71, 160, 8),
  ('MET_006', '2025-01-01 07:00:00', 95.20, 28.0, 5500,  680.0, 78, 148, 6),
  ('MET_007', '2025-01-01 07:00:00', 55.00, 15.0, 12000, 390.0, 60, 140, 9);

-- ============================================================
-- data_source
-- ============================================================
INSERT INTO data_source (source_id, source_name, source_type, format, source_url, expected_records, last_updates, is_active) VALUES
  ('SRC_001', 'OpenFoodFacts',     'Public API',   'JSON', 'https://world.openfoodfacts.org/api',    '50000', '2025-01-10 06:00:00', TRUE),
  ('SRC_002', 'WHO Nutrition DB',  'CSV Export',   'CSV',  'https://www.who.int/data/nutrition',     '10000', '2025-01-01 00:00:00', TRUE),
  ('SRC_003', 'ExerciseDB',        'REST API',     'JSON', 'https://exercisedb.p.rapidapi.com',      '1300',  '2025-01-05 06:00:00', TRUE),
  ('SRC_004', 'User Wearables',    'Device Sync',  'JSON', 'https://internal.sync.example.com',     '99999', '2025-01-14 02:00:00', TRUE),
  ('SRC_005', 'ANSES CIQUAL',      'CSV Export',   'CSV',  'https://ciqual.anses.fr',               '3000',  '2024-12-01 00:00:00', FALSE);

-- ============================================================
-- etl_execution
-- ============================================================
INSERT INTO etl_execution (execution_id, started_at, ended_at, status, records_extracted, records_loaded, records_rejected, error_message, triggered_by, source_id) VALUES
  ('ETL_001', '2025-01-10 06:00:00', '2025-01-10 06:15:00', TRUE,  TRUE,  TRUE,  FALSE, NULL,                  'scheduler', 'SRC_001'),
  ('ETL_002', '2025-01-10 06:15:00', '2025-01-10 06:20:00', TRUE,  TRUE,  TRUE,  FALSE, NULL,                  'scheduler', 'SRC_003'),
  ('ETL_003', '2025-01-14 02:00:00', '2025-01-14 02:45:00', TRUE,  TRUE,  TRUE,  TRUE,  NULL,                  'scheduler', 'SRC_004'),
  ('ETL_004', '2025-01-05 06:00:00', '2025-01-05 06:05:00', FALSE, TRUE,  FALSE, TRUE,  'Connection timeout',  'manual',    'SRC_003'),
  ('ETL_005', '2025-01-01 00:00:00', '2025-01-01 00:30:00', TRUE,  TRUE,  TRUE,  FALSE, NULL,                  'scheduler', 'SRC_002');

-- ============================================================
-- data_quality_check_
-- ============================================================
INSERT INTO data_quality_check_ (check_id, target_table, check_type, check_rule, records_checked, records_failed, checked_at, status, execution_id) VALUES
  ('CHK_001', 'ingredients', 'NULL_CHECK',     'calories_g IS NOT NULL',          '50000', '12',   '2025-01-10 06:16:00', TRUE,  'ETL_001'),
  ('CHK_002', 'ingredients', 'RANGE_CHECK',    'calories_g BETWEEN 0 AND 900',    '50000', '3',    '2025-01-10 06:16:30', TRUE,  'ETL_001'),
  ('CHK_003', 'exercise',    'DUPLICATE_CHECK','DISTINCT exercise_id',             '1300',  '0',    '2025-01-10 06:21:00', TRUE,  'ETL_002'),
  ('CHK_004', 'user_metrics','RANGE_CHECK',    'heart_rate_avg BETWEEN 30 AND 220','99999', '7',   '2025-01-14 02:46:00', TRUE,  'ETL_003'),
  ('CHK_005', 'ingredients', 'NULL_CHECK',     'name IS NOT NULL',                '3000',  '0',    '2025-01-01 00:31:00', TRUE,  'ETL_005');

-- ============================================================
-- data_anomaly
-- ============================================================
INSERT INTO data_anomaly (anomaly_id, source_table, anomaly_table, field_name, record_identifier, original_value, detected_at, severity, is_resolved, resolution_action, check_id, execution_id) VALUES
  ('ANO_001', 'ingredients', 'ingredients', 'calories_g', 'ING_UNKNOWN_001', '-5.0',   '2025-01-10 06:17:00', 'HIGH',   TRUE,  'Set to NULL and flagged for review', 'CHK_002', 'ETL_001'),
  ('ANO_002', 'ingredients', 'ingredients', 'calories_g', 'ING_UNKNOWN_002', '1200.0', '2025-01-10 06:17:05', 'MEDIUM', FALSE, NULL,                                  'CHK_002', 'ETL_001'),
  ('ANO_003', 'user_metrics','user_metrics','heart_rate_avg','MET_UNKNOWN_001','225',   '2025-01-14 02:47:00', 'HIGH',   TRUE,  'Replaced with rolling average',     'CHK_004', 'ETL_003');

-- ============================================================
-- feature
-- ============================================================
INSERT INTO feature (feature_id, name, description, category) VALUES
  ('FT_001', 'AI Meal Planner',          'Personalized weekly meal plans generated by AI',        'Nutrition'),
  ('FT_002', 'Workout Tracker',          'Log and track your workout sessions',                   'Fitness'),
  ('FT_003', 'Biometric Dashboard',      'Real-time overview of biometric and health metrics',    'Analytics'),
  ('FT_004', 'Device Sync',              'Sync data from connected wearables and smart devices',  'Integration'),
  ('FT_005', 'AI Recommendations',       'AI-powered personalized health and wellness tips',      'AI'),
  ('FT_006', 'B2B Admin Panel',          'Organization management and user oversight dashboard',  'B2B'),
  ('FT_007', 'Advanced Analytics',       'Deep analytics, trends, and exportable reports',        'Analytics'),
  ('FT_008', 'Recipe Library',           'Access to curated healthy recipe database',             'Nutrition'),
  ('FT_009', 'Nutrition Tracking',       'Detailed macro and micro nutrient logging',             'Nutrition'),
  ('FT_010', 'Priority Support',         '24/7 dedicated customer support channel',               'Support');

-- ============================================================
-- role
-- ============================================================
INSERT INTO role (role_id, role_type, is_system) VALUES
  ('ROLE_01', 'FREEMIUM',     TRUE),
  ('ROLE_02', 'PREMIUM',      TRUE),
  ('ROLE_03', 'PREMIUM_PLUS', TRUE),
  ('ROLE_04', 'B2B',          TRUE),
  ('ROLE_05', 'ADMIN',        TRUE);

-- ============================================================
-- organization
-- ============================================================
INSERT INTO organization (organization_id, name, org_type, domain) VALUES
  ('ORG_001', 'FitCorp Enterprise',   'COMPANY', 'fitcorp.com'),
  ('ORG_002', 'City Gym Network',     'GYM',     'citygym.fr'),
  ('ORG_003', 'MutualSanté Plus',     'MUTUAL',  'mutualsante.fr'),
  ('ORG_004', 'Green Health NGO',     'NGO',     'greenhealth.org'),
  ('ORG_005', 'SportTech Labs',       'COMPANY', 'sporttech.io');

-- ============================================================
-- subscription_plan
-- ============================================================
INSERT INTO subscription_plan (plan_id, name, description, billing_cycle, price_ht, is_public, created_at, updated_at, role_id) VALUES
  ('PLAN_01', 'Free',         'Basic access with limited features',            'NONE',    0.00,   TRUE,  '2023-01-01', '2024-06-01', 'ROLE_01'),
  ('PLAN_02', 'Premium',      'Full access to all personal features',          'MONTHLY', 9.99,   TRUE,  '2023-01-01', '2024-06-01', 'ROLE_02'),
  ('PLAN_03', 'Premium+',     'Premium features + advanced analytics',         'MONTHLY', 19.99,  TRUE,  '2023-06-01', '2024-06-01', 'ROLE_03'),
  ('PLAN_04', 'Premium Yearly','Full access billed annually (2 months free)', 'YEARLY',  99.99,  TRUE,  '2023-06-01', '2024-06-01', 'ROLE_02'),
  ('PLAN_05', 'B2B Starter',  'Up to 50 users, B2B admin panel',               'MONTHLY', 149.00, FALSE, '2023-09-01', '2024-09-01', 'ROLE_04'),
  ('PLAN_06', 'B2B Enterprise','Unlimited users, full suite + support',        'YEARLY',  999.00, FALSE, '2023-09-01', '2024-09-01', 'ROLE_04');

-- ============================================================
-- has_feature
-- ============================================================
INSERT INTO has_feature (plan_id, feature_id) VALUES
  -- Free
  ('PLAN_01', 'FT_002'),
  ('PLAN_01', 'FT_008'),
  -- Premium
  ('PLAN_02', 'FT_001'),
  ('PLAN_02', 'FT_002'),
  ('PLAN_02', 'FT_004'),
  ('PLAN_02', 'FT_005'),
  ('PLAN_02', 'FT_008'),
  ('PLAN_02', 'FT_009'),
  -- Premium+
  ('PLAN_03', 'FT_001'),
  ('PLAN_03', 'FT_002'),
  ('PLAN_03', 'FT_003'),
  ('PLAN_03', 'FT_004'),
  ('PLAN_03', 'FT_005'),
  ('PLAN_03', 'FT_007'),
  ('PLAN_03', 'FT_008'),
  ('PLAN_03', 'FT_009'),
  ('PLAN_03', 'FT_010'),
  -- Premium Yearly (same as Premium)
  ('PLAN_04', 'FT_001'),
  ('PLAN_04', 'FT_002'),
  ('PLAN_04', 'FT_004'),
  ('PLAN_04', 'FT_005'),
  ('PLAN_04', 'FT_008'),
  ('PLAN_04', 'FT_009'),
  -- B2B Starter
  ('PLAN_05', 'FT_002'),
  ('PLAN_05', 'FT_004'),
  ('PLAN_05', 'FT_006'),
  ('PLAN_05', 'FT_009'),
  -- B2B Enterprise
  ('PLAN_06', 'FT_001'),
  ('PLAN_06', 'FT_002'),
  ('PLAN_06', 'FT_003'),
  ('PLAN_06', 'FT_004'),
  ('PLAN_06', 'FT_005'),
  ('PLAN_06', 'FT_006'),
  ('PLAN_06', 'FT_007'),
  ('PLAN_06', 'FT_008'),
  ('PLAN_06', 'FT_009'),
  ('PLAN_06', 'FT_010');

-- ============================================================
-- user_profile
-- ============================================================
INSERT INTO user_profile (user_id, height_cm, current_weight_kg, activity_level_ref, allergies, diet_type, updated_at, goal_id) VALUES
  ('USR_001', 1.81, 78.50, 'ACTIVE',       'NONE',   'NONE',       '2025-01-14 08:00:00', 'GOAL_002'),
  ('USR_002', 1.65, 62.00, 'MODERATE',     'MILK',   'VEGETARIAN', '2025-01-13 09:00:00', 'GOAL_001'),
  ('USR_003', 1.75, 95.20, 'SEDENTARY',    'GLUTEN', 'NONE',       '2025-01-12 10:00:00', 'GOAL_001'),
  ('USR_004', 1.70, 55.00, 'VERY_ACTIVE',  'NONE',   'VEGAN',      '2025-01-11 11:00:00', 'GOAL_003'),
  ('USR_005', 1.68, 71.00, 'ACTIVE',       'NUTS',   'KETO',       '2025-01-10 12:00:00', 'GOAL_005'),
  ('USR_006', 1.82, 85.00, 'MODERATE',     'NONE',   'NONE',       '2025-01-09 08:00:00', 'GOAL_004'),
  ('USR_007', 1.60, 58.00, 'ACTIVE',       'SOY',    'PESCATARIAN','2025-01-08 09:00:00', 'GOAL_002');

-- ============================================================
-- user_
-- ============================================================
INSERT INTO user_ (user_id, email, password_hash, first_name, last_name, birth_date, gender_code, created_at, is_active, role_code, role_id) VALUES
  ('USR_001', 'alice.martin@email.com',   crypt('Password1!', gen_salt('bf')), 'Alice',   'Martin',   '1990-04-15', 1, '2024-03-01', TRUE,  'PREMIUM',      'ROLE_02'),
  ('USR_002', 'bob.dupont@email.com',     crypt('Password2!', gen_salt('bf')), 'Bob',     'Dupont',   '1985-08-22', 1, '2024-04-10', TRUE,  'FREEMIUM',     'ROLE_01'),
  ('USR_003', 'claire.leroy@email.com',   crypt('Password3!', gen_salt('bf')), 'Claire',  'Leroy',    '1995-12-05', 2, '2024-05-20', TRUE,  'PREMIUM_PLUS', 'ROLE_03'),
  ('USR_004', 'david.petit@email.com',    crypt('Password4!', gen_salt('bf')), 'David',   'Petit',    '1992-06-30', 1, '2024-06-15', TRUE,  'B2B',          'ROLE_04'),
  ('USR_005', 'emma.blanc@email.com',     crypt('Password5!', gen_salt('bf')), 'Emma',    'Blanc',    '1998-02-14', 2, '2024-07-01', TRUE,  'PREMIUM',      'ROLE_02'),
  ('USR_006', 'francois.noir@email.com',  crypt('Password6!', gen_salt('bf')), 'François','Noir',     '1988-09-17', 1, '2024-08-05', FALSE, 'FREEMIUM',     'ROLE_01'),
  ('USR_007', 'admin@healthapp.com',      crypt('AdminPass!', gen_salt('bf')), 'Admin',   'System',   '1980-01-01', 1, '2023-01-01', TRUE,  'ADMIN',        'ROLE_05');

-- ============================================================
-- subscription
-- ============================================================
INSERT INTO subscription (subscription_id, start_date, end_date, status, cancelled_at, cancellation_reason, created_at, updated_at, user_id, plan_id) VALUES
  ('SUB_001', '2024-03-01', '2025-03-01', TRUE,  NULL,         NULL,                    '2024-03-01', '2024-03-01', 'USR_001', 'PLAN_02'),
  ('SUB_002', '2024-04-10', NULL,         TRUE,  NULL,         NULL,                    '2024-04-10', '2024-04-10', 'USR_002', 'PLAN_01'),
  ('SUB_003', '2024-05-20', '2025-05-20', TRUE,  NULL,         NULL,                    '2024-05-20', '2024-05-20', 'USR_003', 'PLAN_03'),
  ('SUB_004', '2024-06-15', '2025-06-15', TRUE,  NULL,         NULL,                    '2024-06-15', '2024-06-15', 'USR_004', 'PLAN_05'),
  ('SUB_005', '2024-07-01', '2025-07-01', TRUE,  NULL,         NULL,                    '2024-07-01', '2024-07-01', 'USR_005', 'PLAN_04'),
  ('SUB_006', '2024-08-05', '2024-11-05', FALSE, '2024-11-05', 'Too expensive',         '2024-08-05', '2024-11-05', 'USR_006', 'PLAN_02'),
  ('SUB_007', '2024-01-01', '2025-01-01', TRUE,  NULL,         NULL,                    '2024-01-01', '2024-01-01', 'USR_004', 'PLAN_06');

-- ============================================================
-- has_access (subscription <-> organization)
-- ============================================================
INSERT INTO has_access (subscription_id, organization_id) VALUES
  ('SUB_004', 'ORG_001'),
  ('SUB_007', 'ORG_005');

-- ============================================================
-- Parts_of (user <-> organization)
-- ============================================================
INSERT INTO Parts_of (user_id, organization_id) VALUES
  ('USR_004', 'ORG_001'),
  ('USR_001', 'ORG_002'),
  ('USR_003', 'ORG_003'),
  ('USR_007', 'ORG_005');

-- ============================================================
-- payment_transaction
-- ============================================================
INSERT INTO payment_transaction (transaction_id, processed_at, amount_ht, status, created_at, subscription_id) VALUES
  ('TRX_001', '2024-03-01 12:00:00', 9.99,   TRUE,  '2024-03-01', 'SUB_001'),
  ('TRX_002', '2024-04-01 12:00:00', 9.99,   TRUE,  '2024-04-01', 'SUB_001'),
  ('TRX_003', '2024-05-20 09:30:00', 19.99,  TRUE,  '2024-05-20', 'SUB_003'),
  ('TRX_004', '2024-06-15 10:00:00', 149.00, TRUE,  '2024-06-15', 'SUB_004'),
  ('TRX_005', '2024-07-01 14:00:00', 99.99,  TRUE,  '2024-07-01', 'SUB_005'),
  ('TRX_006', '2024-08-05 11:00:00', 9.99,   TRUE,  '2024-08-05', 'SUB_006'),
  ('TRX_007', '2024-09-05 11:00:00', 9.99,   FALSE, '2024-09-05', 'SUB_006'),
  ('TRX_008', '2024-01-01 08:00:00', 999.00, TRUE,  '2024-01-01', 'SUB_007');

-- ============================================================
-- subscription_history
-- ============================================================
INSERT INTO subscription_history (history_id, status_event, previous_role, new_role, occurred_at_, plan_id, plan_id_1, user_id, subscription_id) VALUES
  ('SHIST_001', 'UPGRADED',   'FREEMIUM', 'PREMIUM',      '2024-03-01', 'PLAN_01', 'PLAN_02', 'USR_001', 'SUB_001'),
  ('SHIST_002', 'UPGRADED',   'PREMIUM',  'PREMIUM_PLUS', '2024-05-20', 'PLAN_02', 'PLAN_03', 'USR_003', 'SUB_003'),
  ('SHIST_003', 'CANCELLED',  'PREMIUM',  'FREEMIUM',     '2024-11-05', 'PLAN_02', 'PLAN_01', 'USR_006', 'SUB_006'),
  ('SHIST_004', 'UPGRADED',   'FREEMIUM', 'B2B',          '2024-06-15', 'PLAN_01', 'PLAN_05', 'USR_004', 'SUB_004');

-- ============================================================
-- meal
-- ============================================================
INSERT INTO meal (meal_id, consumed_at, quantity_grams, diet_type, calories_consumed, ingredients, user_id) VALUES
  ('MEAL_001', '2025-01-14', 350, 'NONE',        520,  'Chicken, Broccoli',      'USR_001'),
  ('MEAL_002', '2025-01-14', 400, 'VEGETARIAN',  610,  'Oats, Yogurt, Banana',   'USR_002'),
  ('MEAL_003', '2025-01-14', 300, 'NONE',        480,  'Salmon, Brown Rice',     'USR_003'),
  ('MEAL_004', '2025-01-14', 250, 'VEGAN',       310,  'Spinach, Oats',          'USR_004'),
  ('MEAL_005', '2025-01-13', 500, 'KETO',        820,  'Chicken, Olive Oil',     'USR_005'),
  ('MEAL_006', '2025-01-13', 300, 'NONE',        450,  'Brown Rice, Broccoli',   'USR_001'),
  ('MEAL_007', '2025-01-13', 200, 'PESCATARIAN', 350,  'Salmon, Spinach',        'USR_007');

-- ============================================================
-- consumes (meal <-> ingredients)
-- ============================================================
INSERT INTO consumes (ingredients_id, meal_id, quantity) VALUES
  ('ING_001', 'MEAL_001', 200),
  ('ING_002', 'MEAL_001', 150),
  ('ING_008', 'MEAL_002',  80),
  ('ING_009', 'MEAL_002', 100),
  ('ING_005', 'MEAL_002',  80),
  ('ING_006', 'MEAL_003', 180),
  ('ING_003', 'MEAL_003', 100),
  ('ING_010', 'MEAL_004', 100),
  ('ING_008', 'MEAL_004',  80),
  ('ING_001', 'MEAL_005', 250),
  ('ING_007', 'MEAL_005',  20),
  ('ING_003', 'MEAL_006', 150),
  ('ING_002', 'MEAL_006', 100),
  ('ING_006', 'MEAL_007', 150),
  ('ING_010', 'MEAL_007',  80);

-- ============================================================
-- workout_session
-- ============================================================
INSERT INTO workout_session (session_id, start_time, duration_time, calories_burned, notes, user_id) VALUES
  ('WS_001', '2025-01-14', 60, 450, 'Morning strength session',         'USR_001'),
  ('WS_002', '2025-01-14', 45, 380, 'Yoga and flexibility',             'USR_002'),
  ('WS_003', '2025-01-13', 75, 600, 'HIIT circuit training',            'USR_003'),
  ('WS_004', '2025-01-14', 90, 520, 'Long run + core',                  'USR_004'),
  ('WS_005', '2025-01-12', 50, 410, 'Upper body hypertrophy',           'USR_005'),
  ('WS_006', '2025-01-11', 30, 200, 'Light stretching session',         'USR_006'),
  ('WS_007', '2025-01-14', 60, 480, 'Full body compound movements',     'USR_007');

-- ============================================================
-- exercice_details
-- ============================================================
INSERT INTO exercice_details (exercice_details_id, sets, reps, exercise_id, session_id) VALUES
  ('ED_001', 4, 12, 'EXC_001', 'WS_001'),
  ('ED_002', 4, 10, 'EXC_009', 'WS_001'),
  ('ED_003', 3, 15, 'EXC_005', 'WS_001'),
  ('ED_004', 3,  0, 'EXC_007', 'WS_002'),
  ('ED_005', 5, 20, 'EXC_008', 'WS_003'),
  ('ED_006', 4, 12, 'EXC_001', 'WS_003'),
  ('ED_007', 1,  0, 'EXC_004', 'WS_004'),
  ('ED_008', 3, 15, 'EXC_005', 'WS_004'),
  ('ED_009', 4, 10, 'EXC_006', 'WS_005'),
  ('ED_010', 4, 12, 'EXC_009', 'WS_005'),
  ('ED_011', 3,  0, 'EXC_007', 'WS_006'),
  ('ED_012', 4, 10, 'EXC_003', 'WS_007'),
  ('ED_013', 4, 12, 'EXC_002', 'WS_007');

-- ============================================================
-- biometric_measure
-- ============================================================
INSERT INTO biometric_measure (measure_id, type, value_, measured_at, user_id) VALUES
  ('BIO_001', 'heart_rate',  68,  '2025-01-14 07:00:00', 'USR_001'),
  ('BIO_002', 'weight_kg',   79,  '2025-01-14 07:05:00', 'USR_001'),
  ('BIO_003', 'spo2',        98,  '2025-01-14 07:10:00', 'USR_001'),
  ('BIO_004', 'heart_rate',  72,  '2025-01-14 08:00:00', 'USR_002'),
  ('BIO_005', 'weight_kg',   62,  '2025-01-14 08:05:00', 'USR_002'),
  ('BIO_006', 'heart_rate',  78,  '2025-01-14 07:30:00', 'USR_003'),
  ('BIO_007', 'weight_kg',   95,  '2025-01-14 07:35:00', 'USR_003'),
  ('BIO_008', 'steps',       12000,'2025-01-14 23:59:00','USR_004'),
  ('BIO_009', 'heart_rate',  60,  '2025-01-14 06:00:00', 'USR_004'),
  ('BIO_010', 'heart_rate',  70,  '2025-01-13 07:00:00', 'USR_005');

-- ============================================================
-- pairs (user <-> device)
-- ============================================================
INSERT INTO pairs (user_id, device_id) VALUES
  ('USR_001', 'DEV_001'),
  ('USR_002', 'DEV_004'),
  ('USR_003', 'DEV_003'),
  ('USR_004', 'DEV_002'),
  ('USR_005', 'DEV_005'),
  ('USR_007', 'DEV_001');

-- ============================================================
-- records (device <-> biometric_measure)
-- ============================================================
INSERT INTO records (device_id, measure_id) VALUES
  ('DEV_001', 'BIO_001'),
  ('DEV_001', 'BIO_002'),
  ('DEV_001', 'BIO_003'),
  ('DEV_004', 'BIO_004'),
  ('DEV_004', 'BIO_005'),
  ('DEV_003', 'BIO_006'),
  ('DEV_003', 'BIO_007'),
  ('DEV_002', 'BIO_008'),
  ('DEV_002', 'BIO_009'),
  ('DEV_005', 'BIO_010');

-- ============================================================
-- links (user <-> data_source)
-- ============================================================
INSERT INTO links (user_id, source_id) VALUES
  ('USR_001', 'SRC_004'),
  ('USR_002', 'SRC_001'),
  ('USR_003', 'SRC_004'),
  ('USR_004', 'SRC_004'),
  ('USR_005', 'SRC_004'),
  ('USR_007', 'SRC_002');

-- ============================================================
-- gets (health_goal <-> user_metrics)
-- ============================================================
INSERT INTO gets (goal_id, metric_id) VALUES
  ('GOAL_002', 'MET_001'),
  ('GOAL_002', 'MET_002'),
  ('GOAL_001', 'MET_004'),
  ('GOAL_001', 'MET_005'),
  ('GOAL_001', 'MET_006'),
  ('GOAL_003', 'MET_007');

-- ============================================================
-- ai_recommendation
-- ============================================================
INSERT INTO ai_recommendation (recommendation_id, generated_at, category, title, content_text, confidence_score, is_viewed, feedback_rating, user_id) VALUES
  ('AIREC_001', '2025-01-14 08:30:00', 'Nutrition',  'Increase protein intake',        'Based on your workouts and goals, consider adding 20g more protein daily.',         0.92, TRUE,  4.5, 'USR_001'),
  ('AIREC_002', '2025-01-14 09:00:00', 'Sleep',      'Improve sleep consistency',      'Your sleep data shows irregular patterns. Try going to bed at the same time nightly.',0.85, TRUE,  4.0, 'USR_001'),
  ('AIREC_003', '2025-01-13 10:00:00', 'Fitness',    'Add cardio sessions',            'Your heart rate data suggests you could benefit from 2 cardio sessions per week.',    0.78, FALSE, NULL,'USR_002'),
  ('AIREC_004', '2025-01-14 07:00:00', 'Nutrition',  'Reduce sodium consumption',      'Your recent meals show elevated sodium. Target under 2000mg per day.',               0.88, TRUE,  3.5, 'USR_003'),
  ('AIREC_005', '2025-01-12 11:00:00', 'Recovery',   'Rest day recommended',           'You have trained 5 days consecutively. A rest day will help muscle recovery.',       0.95, TRUE,  5.0, 'USR_004'),
  ('AIREC_006', '2025-01-11 09:30:00', 'Hydration',  'Increase daily water intake',    'Tracking suggests your hydration is below optimal. Aim for 2.5L daily.',             0.80, FALSE, NULL,'USR_005');

-- ============================================================
-- diet_recommendation
-- ============================================================
INSERT INTO diet_recommendation (recommendation_id, recommended_foods, total_calories, protein_g, carbs_g, fat_g, diet_type, generated_at, is_followed, user_id) VALUES
  ('DREC_001', 'Chicken breast, brown rice, broccoli, Greek yogurt',  2200, 165.0, 220.0, 55.0,  'NONE',       '2025-01-14 08:00:00', TRUE,  'USR_001'),
  ('DREC_002', 'Oats, banana, spinach, Greek yogurt, lentils',        1800, 85.0,  250.0, 40.0,  'VEGETARIAN', '2025-01-13 09:00:00', FALSE, 'USR_002'),
  ('DREC_003', 'Salmon, brown rice, broccoli, olive oil',             2400, 140.0, 200.0, 80.0,  'NONE',       '2025-01-14 07:30:00', TRUE,  'USR_003'),
  ('DREC_004', 'Oats, spinach, banana, soy milk, tofu',               1700, 80.0,  220.0, 45.0,  'VEGAN',      '2025-01-12 10:00:00', TRUE,  'USR_004'),
  ('DREC_005', 'Chicken, olive oil, eggs, cheese, avocado',           2100, 150.0, 30.0,  140.0, 'KETO',       '2025-01-11 08:00:00', FALSE, 'USR_005');