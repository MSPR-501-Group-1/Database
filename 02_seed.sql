-- ============================================================
-- SEED PostgreSQL
-- ============================================================

-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- health_goal
-- ============================================================
INSERT INTO health_goal (goal_id, label, description) VALUES
  ('GOAL_001', 'Weight Loss',      'Reduce body weight through balanced diet and exercise'),
  ('GOAL_002', 'Muscle Gain',      'Increase lean muscle mass through strength training'),
  ('GOAL_003', 'Endurance',        'Improve cardiovascular endurance and stamina'),
  ('GOAL_004', 'Flexibility',      'Enhance range of motion and reduce injury risk'),
  ('GOAL_005', 'General Wellness', 'Maintain overall health and well-being');

-- ============================================================
-- ingredient
-- ============================================================
INSERT INTO ingredient (
  ingredient_id,
  name,
  category,
  nutriscore,
  calories_g,
  fat_g,
  fiber_g,
  sugar_g,
  sodium_mg,
  cholesterol_mg,
  protein_g,
  carbs_g
) VALUES
  ('ING_001', 'Chicken Breast', 'MEAT',      'A', 1.65, 0.36,  0.0,  0.0, 74.0, 85.0, 31.0,  0.0),
  ('ING_002', 'Broccoli',       'VEGETABLE', 'A', 0.34, 0.04,  2.6,  0.7, 33.0,  0.0,  2.8,  7.0),
  ('ING_003', 'Brown Rice',     'GRAIN',     'B', 1.11, 0.09,  1.8,  0.4,  5.0,  0.0,  2.6, 23.0),
  ('ING_004', 'Whole Milk',     'DAIRY',     'C', 0.61, 0.33,  0.0,  4.8, 44.0, 10.0,  3.2,  4.8),
  ('ING_005', 'Banana',         'FRUIT',     'A', 0.89, 0.03,  2.6, 12.2,  1.0,  0.0,  1.1, 23.0),
  ('ING_006', 'Salmon',         'MEAT',      'A', 2.08, 1.30,  0.0,  0.0, 59.0, 63.0, 20.0,  0.0),
  ('ING_007', 'Olive Oil',      'OTHER',     'D', 8.84,10.00,  0.0,  0.0,  0.0,  0.0,  0.0,  0.0),
  ('ING_008', 'Oats',           'GRAIN',     'A', 3.89, 0.67, 10.6,  0.0,  2.0,  0.0, 16.9, 66.0),
  ('ING_009', 'Greek Yogurt',   'DAIRY',     'A', 0.59, 0.04,  0.0,  3.2, 36.0,  5.0, 10.0,  3.6),
  ('ING_010', 'Spinach',        'VEGETABLE', 'A', 0.23, 0.04,  2.2,  0.4, 79.0,  0.0,  2.9,  3.6);

-- ============================================================
-- recipe
-- ============================================================
INSERT INTO recipe (recipe_id, title, instructions) VALUES
  ('RCP_001', 'Grilled Chicken and Broccoli',
   'Season chicken with salt and pepper. Grill 6 min each side. Steam broccoli 5 min. Serve together.'),
  ('RCP_002', 'Salmon Rice Bowl',
   'Cook brown rice. Pan-sear salmon 4 min each side with olive oil. Serve over rice with spinach.'),
  ('RCP_003', 'Overnight Oats',
   'Mix oats with milk and yogurt. Add banana slices. Refrigerate overnight. Serve cold.'),
  ('RCP_004', 'Spinach Omelette',
   'Beat eggs. Cook spinach in olive oil 2 min. Pour eggs over and fold when set.'),
  ('RCP_005', 'Protein Power Bowl',
   'Cook brown rice. Grill chicken breast. Saute broccoli and spinach. Assemble bowl and drizzle olive oil.');

-- ============================================================
-- exercise
-- ============================================================
INSERT INTO exercise (
  exercise_id,
  name,
  description,
  body_part_target,
  video_url,
  difficulty_level,
  equipment_required,
  category
) VALUES
  ('EXC_001', 'Push-Up',     'Classic bodyweight chest exercise',          'CHEST',     'https://videos.example.com/pushup',     'BEGINNER',     'None',          'STRENGTH'),
  ('EXC_002', 'Squat',       'Fundamental lower body strength movement',   'LEGS',      'https://videos.example.com/squat',      'BEGINNER',     'None',          'STRENGTH'),
  ('EXC_003', 'Deadlift',    'Compound posterior chain exercise',          'BACK',      'https://videos.example.com/deadlift',   'INTERMEDIATE', 'Barbell',       'STRENGTH'),
  ('EXC_004', 'Running',     'Steady-state cardio session',                'FULL_BODY', 'https://videos.example.com/running',    'BEGINNER',     'Shoes',         'CARDIO'),
  ('EXC_005', 'Plank',       'Isometric core stability hold',              'CORE',      'https://videos.example.com/plank',      'BEGINNER',     'None',          'BALANCE'),
  ('EXC_006', 'Pull-Up',     'Vertical pulling bodyweight movement',       'BACK',      'https://videos.example.com/pullup',     'INTERMEDIATE', 'Pull-up bar',   'STRENGTH'),
  ('EXC_007', 'Yoga Flow',   'Dynamic flexibility and breathing sequence', 'FULL_BODY', 'https://videos.example.com/yoga',       'BEGINNER',     'Yoga mat',      'FLEXIBILITY'),
  ('EXC_008', 'Burpee',      'High-intensity full body conditioning',      'FULL_BODY', 'https://videos.example.com/burpee',     'INTERMEDIATE', 'None',          'CARDIO'),
  ('EXC_009', 'Bench Press', 'Horizontal pressing strength exercise',      'CHEST',     'https://videos.example.com/benchpress', 'INTERMEDIATE', 'Barbell+Bench', 'STRENGTH'),
  ('EXC_010', 'Jump Rope',   'High-intensity cardiovascular drill',        'FULL_BODY', 'https://videos.example.com/jumprope',   'BEGINNER',     'Jump rope',     'CARDIO');

-- ============================================================
-- etl_execution
-- ============================================================
INSERT INTO etl_execution (
  execution_id,
  name,
  started_at,
  ended_at,
  status,
  records_extracted,
  records_loaded,
  records_rejected,
  error_message
) VALUES
  ('ETL_001', 'Nutrition', '2025-01-10 06:00:00', '2025-01-10 06:15:00', 'REJECTED',  49988, 49988,    0, NULL),
  ('ETL_002', 'Exercises', '2025-01-10 06:15:00', '2025-01-10 06:20:00', 'LOADED',   1300,  1300,    0, NULL),
  ('ETL_003', 'Nutrition', '2025-01-14 02:00:00', '2025-01-14 02:45:00', 'LOADED',  99999, 98500,  750, NULL),
  ('ETL_004', 'Exercises', '2025-01-05 06:00:00', '2025-01-05 06:05:00', 'TRANSFORMED',  1300,     0, 1300, 'Connection timeout'),
  ('ETL_005', 'Nutrition', '2025-01-01 00:30:00', '2025-01-01 00:45:00', 'TRANSFORMED',    3000, 3000,    0, NULL);
-- ============================================================
-- data_quality_check_
-- ============================================================
INSERT INTO data_quality_check_ (
  check_id,
  target_table,
  check_type,
  check_rule,
  records_checked,
  records_failed,
  checked_at,
  status,
  execution_id
) VALUES
  ('CHK_001', 'ingredient',   'NULL_CHECK',      'calories_g IS NOT NULL',           50000, 12, '2025-01-10 06:16:00', TRUE, 'ETL_001'),
  ('CHK_002', 'ingredient',   'RANGE_CHECK',     'calories_g BETWEEN 0 AND 900',     50000,  3, '2025-01-10 06:16:30', TRUE, 'ETL_001'),
  ('CHK_003', 'exercise',     'DUPLICATE_CHECK', 'DISTINCT exercise_id',              1300,  0, '2025-01-10 06:21:00', TRUE, 'ETL_002'),
  ('CHK_004', 'user_metrics', 'RANGE_CHECK',     'heart_rate_avg BETWEEN 30 AND 220', 99999, 7, '2025-01-14 02:46:00', TRUE, 'ETL_003'),
  ('CHK_005', 'ingredient',   'NULL_CHECK',      'name IS NOT NULL',                   3000,  0, '2025-01-01 00:31:00', TRUE, 'ETL_005');

-- ============================================================
-- data_anomaly
-- ============================================================
INSERT INTO data_anomaly (
  anomaly_id,
  source_table,
  anomaly_table,
  field_name,
  record_identifier,
  original_value,
  detected_at,
  severity,
  is_resolved,
  resolution_action,
  check_id,
  execution_id
) VALUES
  ('ANO_001', 'ingredient',   'ingredient',   'calories_g',    'ING_UNKNOWN_001', '-5.0',   '2025-01-10 06:17:00', 'HIGH',   TRUE,  'Set to NULL and flagged for review', 'CHK_002', 'ETL_001'),
  ('ANO_002', 'ingredient',   'ingredient',   'calories_g',    'ING_UNKNOWN_002', '1200.0', '2025-01-10 06:17:05', 'MEDIUM', FALSE, NULL,                                  'CHK_002', 'ETL_001'),
  ('ANO_003', 'user_metrics', 'user_metrics', 'heart_rate_avg','MET_UNKNOWN_001', '225',    '2025-01-14 02:47:00', 'HIGH',   TRUE,  'Replaced with rolling average',      'CHK_004', 'ETL_003');

-- ============================================================
-- role
-- ============================================================
INSERT INTO role (role_id, role_type, is_system) VALUES
  ('ROLE_01', 'FREEMIUM',     FALSE),
  ('ROLE_02', 'PREMIUM',      FALSE),
  ('ROLE_03', 'PREMIUM_PLUS', FALSE),
  ('ROLE_04', 'B2B',          FALSE),
  ('ROLE_05', 'ADMIN',        TRUE);

-- ============================================================
-- organization
-- ============================================================
INSERT INTO organization (organization_id, name) VALUES
  ('ORG_001', 'FitCorp Enterprise'),
  ('ORG_002', 'City Gym Network'),
  ('ORG_003', 'MutualSante Plus'),
  ('ORG_004', 'Green Health NGO'),
  ('ORG_005', 'SportTech Labs');

-- ============================================================
-- user_
-- ============================================================
INSERT INTO user_ (
  user_id,
  email,
  password_hash,
  first_name,
  last_name,
  birth_date,
  gender_code,
  height_cm,
  current_weight_kg,
  allergies,
  diet_type,
  is_active,
  role_id,
  created_at,
  updated_at
) VALUES
  ('USR_001', 'alice.martin@email.com',  crypt('Password1!', gen_salt('bf')), 'Alice',    'Martin',   '1990-04-15', 1, 1.81, 78.50, 'NONE',   'NONE',       TRUE,  'ROLE_02', '2024-03-01', '2025-01-14 08:00:00'),
  ('USR_002', 'bob.dupont@email.com',    crypt('Password2!', gen_salt('bf')), 'Bob',      'Dupont',   '1985-08-22', 1, 1.65, 62.00, 'MILK',   'VEGETARIAN', TRUE,  'ROLE_01', '2024-04-10', '2025-01-13 09:00:00'),
  ('USR_003', 'claire.leroy@email.com',  crypt('Password3!', gen_salt('bf')), 'Claire',   'Leroy',    '1995-12-05', 2, 1.75, 95.20, 'GLUTEN', 'NONE',       TRUE,  'ROLE_03', '2024-05-20', '2025-01-12 10:00:00'),
  ('USR_004', 'david.petit@email.com',   crypt('Password4!', gen_salt('bf')), 'David',    'Petit',    '1992-06-30', 1, 1.70, 55.00, 'NONE',   'VEGAN',      TRUE,  'ROLE_04', '2024-06-15', '2025-01-11 11:00:00'),
  ('USR_005', 'emma.blanc@email.com',    crypt('Password5!', gen_salt('bf')), 'Emma',     'Blanc',    '1998-02-14', 2, 1.68, 71.00, 'NUTS',   'KETO',       TRUE,  'ROLE_02', '2024-07-01', '2025-01-10 12:00:00'),
  ('USR_006', 'francois.noir@email.com', crypt('Password6!', gen_salt('bf')), 'Francois', 'Noir',     '1988-09-17', 1, 1.82, 85.00, 'NONE',   'NONE',       FALSE, 'ROLE_01', '2024-08-05', '2025-01-09 08:00:00'),
  ('USR_007', 'admin@healthapp.com',     crypt('AdminPass!', gen_salt('bf')), 'Admin',    'System',   '1980-01-01', 1, 1.60, 58.00, 'SOY',    'PESCATARIAN',TRUE,  'ROLE_05', '2023-01-01', '2025-01-08 09:00:00');

-- ============================================================
-- user_metrics
-- ============================================================
INSERT INTO user_metrics (
  metric_id,
  user_id,
  recorded_date,
  weight_kg,
  body_fat_pourcentage,
  steps,
  calories_burned,
  heart_rate_avg,
  heart_rate_max,
  sleep_hours
) VALUES
  ('MET_001', 'USR_001', '2025-01-01 07:00:00', 78.50, 18.5,  9200, 520.0, 68, 145, 7),
  ('MET_002', 'USR_001', '2025-01-02 07:00:00', 78.30, 18.4, 11500, 610.0, 70, 162, 8),
  ('MET_003', 'USR_001', '2025-01-03 07:00:00', 78.10, 18.3,  7800, 480.0, 67, 138, 6),
  ('MET_004', 'USR_002', '2025-01-01 07:00:00', 62.00, 22.1,  8500, 420.0, 72, 155, 7),
  ('MET_005', 'USR_002', '2025-01-02 07:00:00', 61.80, 22.0, 10200, 510.0, 71, 160, 8),
  ('MET_006', 'USR_003', '2025-01-01 07:00:00', 95.20, 28.0,  5500, 680.0, 78, 148, 6),
  ('MET_007', 'USR_004', '2025-01-01 07:00:00', 55.00, 15.0, 12000, 390.0, 60, 140, 9);

-- ============================================================
-- login_history
-- ============================================================
INSERT INTO login_history (last_login_id, user_id, last_login) VALUES
  ('LOG_001', 'USR_001', '2025-01-14 08:10:00'),
  ('LOG_002', 'USR_002', '2025-01-14 09:05:00'),
  ('LOG_003', 'USR_003', '2025-01-14 10:20:00'),
  ('LOG_004', 'USR_004', '2025-01-14 11:00:00'),
  ('LOG_005', 'USR_005', '2025-01-13 18:35:00'),
  ('LOG_006', 'USR_007', '2025-01-14 06:45:00'),
  ('LOG_007', 'USR_001', '2026-03-21 08:05:00'),
  ('LOG_008', 'USR_002', '2026-03-21 08:40:00'),
  ('LOG_009', 'USR_003', '2026-03-21 09:10:00'),
  ('LOG_010', 'USR_004', '2026-03-20 07:55:00'),
  ('LOG_011', 'USR_005', '2026-03-20 08:20:00'),
  ('LOG_012', 'USR_006', '2026-03-20 21:40:00'),
  ('LOG_013', 'USR_007', '2026-03-20 06:35:00'),
  ('LOG_014', 'USR_001', '2026-03-19 07:50:00'),
  ('LOG_015', 'USR_002', '2026-03-19 19:20:00'),
  ('LOG_016', 'USR_003', '2026-03-18 08:15:00'),
  ('LOG_017', 'USR_004', '2026-03-18 12:55:00'),
  ('LOG_018', 'USR_005', '2026-03-18 20:40:00'),
  ('LOG_019', 'USR_006', '2026-03-17 22:10:00'),
  ('LOG_020', 'USR_007', '2026-03-17 07:05:00'),
  ('LOG_021', 'USR_001', '2026-03-16 08:10:00'),
  ('LOG_022', 'USR_002', '2026-03-15 08:45:00'),
  ('LOG_023', 'USR_003', '2026-03-15 13:05:00'),
  ('LOG_024', 'USR_004', '2026-03-14 09:30:00'),
  ('LOG_025', 'USR_005', '2026-03-13 18:40:00'),
  ('LOG_026', 'USR_006', '2026-03-12 20:10:00'),
  ('LOG_027', 'USR_007', '2026-03-11 19:50:00'),
  ('LOG_028', 'USR_001', '2026-02-28 08:05:00'),
  ('LOG_029', 'USR_002', '2026-02-21 08:25:00'),
  ('LOG_030', 'USR_003', '2026-02-14 18:55:00'),
  ('LOG_031', 'USR_004', '2026-02-10 07:10:00'),
  ('LOG_032', 'USR_005', '2026-01-20 18:05:00'),
  ('LOG_033', 'USR_006', '2026-01-05 18:40:00'),
  ('LOG_034', 'USR_007', '2025-12-15 08:30:00');

-- ============================================================
-- meal
-- ============================================================
INSERT INTO meal (meal_id, consumed_at, quantity_grams, calories_consumed, user_id) VALUES
  ('MEAL_001', '2025-01-14 12:00:00', 350, 520, 'USR_001'),
  ('MEAL_002', '2025-01-14 08:30:00', 400, 610, 'USR_002'),
  ('MEAL_003', '2025-01-14 13:10:00', 300, 480, 'USR_003'),
  ('MEAL_004', '2025-01-14 19:00:00', 250, 310, 'USR_004'),
  ('MEAL_005', '2025-01-13 20:00:00', 500, 820, 'USR_005'),
  ('MEAL_006', '2025-01-13 12:40:00', 300, 450, 'USR_001'),
  ('MEAL_007', '2025-01-13 21:15:00', 200, 350, 'USR_007');

-- ============================================================
-- workout_session
-- ============================================================
INSERT INTO workout_session (session_id, start_at, end_at, calories_burned, notes, user_id) VALUES
  ('WS_001', '2026-03-14 06:30:00', '2026-03-14 07:30:00', 450, 'Morning strength session',     'USR_001'),
  ('WS_002', '2026-03-14 07:15:00', '2026-03-14 08:00:00', 380, 'Yoga and flexibility',         'USR_002'),
  ('WS_003', '2026-03-13 18:00:00', '2026-03-13 19:15:00', 600, 'HIIT circuit training',        'USR_003'),
  ('WS_004', '2026-03-14 05:45:00', '2026-03-14 07:15:00', 520, 'Long run and core work',       'USR_004'),
  ('WS_005', '2026-03-12 17:30:00', '2026-03-12 18:20:00', 410, 'Upper body hypertrophy',       'USR_005'),
  ('WS_006', '2026-03-11 19:00:00', '2026-03-11 19:30:00', 200, 'Light stretching session',     'USR_006'),
  ('WS_007', '2026-03-14 20:00:00', '2026-03-14 21:00:00', 480, 'Full body compound movements', 'USR_007'),
  ('WS_008',  '2026-03-21 06:15:00', '2026-03-21 07:00:00', 320, 'Morning run',                'USR_001'),
  ('WS_009',  '2026-03-21 18:00:00', '2026-03-21 18:45:00', 280, 'Evening HIIT',               'USR_002'),
  ('WS_010',  '2026-03-20 07:00:00', '2026-03-20 07:50:00', 410, 'Strength circuit',           'USR_003'),
  ('WS_011',  '2026-03-20 12:30:00', '2026-03-20 13:10:00', 300, 'Lunchtime cardio',           'USR_004'),
  ('WS_012',  '2026-03-20 19:00:00', '2026-03-20 19:40:00', 360, 'Yoga flow',                  'USR_005'),
  ('WS_013',  '2026-03-20 21:00:00', '2026-03-20 21:30:00', 210, 'Stretching',                 'USR_006'),
  ('WS_014',  '2026-03-19 06:45:00', '2026-03-19 07:30:00', 350, 'Interval run',               'USR_007'),
  ('WS_015',  '2026-03-19 08:30:00', '2026-03-19 09:10:00', 330, 'Core + mobility',            'USR_001'),
  ('WS_016',  '2026-03-19 18:15:00', '2026-03-19 19:00:00', 400, 'Crossfit WOD',               'USR_002'),
  ('WS_017',  '2026-03-18 07:20:00', '2026-03-18 08:05:00', 360, 'Hill sprints',               'USR_003'),
  ('WS_018',  '2026-03-18 12:00:00', '2026-03-18 12:40:00', 290, 'Rowing session',             'USR_004'),
  ('WS_019',  '2026-03-18 19:30:00', '2026-03-18 20:10:00', 300, 'Pilates',                    'USR_005'),
  ('WS_020',  '2026-03-18 21:15:00', '2026-03-18 21:45:00', 200, 'Cooldown',                   'USR_006'),
  ('WS_021',  '2026-03-17 06:00:00', '2026-03-17 06:50:00', 380, 'Tempo run',                  'USR_007'),
  ('WS_022',  '2026-03-17 08:15:00', '2026-03-17 09:05:00', 420, 'Upper body',                 'USR_001'),
  ('WS_023',  '2026-03-17 12:45:00', '2026-03-17 13:20:00', 260, 'Quick cardio',               'USR_002'),
  ('WS_024',  '2026-03-17 18:00:00', '2026-03-17 19:00:00', 480, 'Long ride',                  'USR_003'),
  ('WS_025',  '2026-03-16 06:30:00', '2026-03-16 07:20:00', 390, 'Strength',                   'USR_004'),
  ('WS_026',  '2026-03-16 09:00:00', '2026-03-16 09:40:00', 310, 'Yoga',                       'USR_005'),
  ('WS_027',  '2026-03-16 17:30:00', '2026-03-16 18:10:00', 300, 'Circuit',                    'USR_006'),
  ('WS_028',  '2026-03-16 19:45:00', '2026-03-16 20:30:00', 420, 'Boxing',                     'USR_007'),
  ('WS_029',  '2026-03-15 06:10:00', '2026-03-15 06:50:00', 320, 'Easy run',                   'USR_001'),
  ('WS_030',  '2026-03-15 07:30:00', '2026-03-15 08:10:00', 300, 'Mobility',                   'USR_002'),
  ('WS_031',  '2026-03-15 12:15:00', '2026-03-15 12:55:00', 280, 'Rowing',                     'USR_003'),
  ('WS_032',  '2026-03-15 17:00:00', '2026-03-15 17:45:00', 360, 'Strength + cardio',          'USR_004'),
  ('WS_033',  '2026-03-15 19:00:00', '2026-03-15 19:40:00', 330, 'HIIT',                       'USR_005'),
  ('WS_034',  '2026-03-15 20:30:00', '2026-03-15 21:00:00', 200, 'Stretch',                    'USR_006'),
  ('WS_035',  '2026-03-10 07:10:00', '2026-03-10 07:50:00', 300, 'Morning run',                'USR_007'),
  ('WS_036',  '2026-03-09 18:00:00', '2026-03-09 18:45:00', 340, 'Cross training',             'USR_001'),
  ('WS_037',  '2026-03-08 06:30:00', '2026-03-08 07:10:00', 310, 'Hill repeats',               'USR_002'),
  ('WS_038',  '2026-03-07 12:00:00', '2026-03-07 12:40:00', 270, 'Lunchtime circuit',          'USR_003'),
  ('WS_039',  '2026-03-06 19:00:00', '2026-03-06 19:50:00', 380, 'Strength',                   'USR_004'),
  ('WS_040',  '2026-03-05 07:15:00', '2026-03-05 07:55:00', 290, 'Recovery',                   'USR_005'),
  ('WS_041',  '2026-03-04 18:20:00', '2026-03-04 19:00:00', 350, 'Run',                        'USR_006'),
  ('WS_042',  '2026-03-03 06:50:00', '2026-03-03 07:35:00', 390, 'Interval',                   'USR_007'),
  ('WS_043',  '2026-03-02 08:00:00', '2026-03-02 08:40:00', 300, 'Yoga',                       'USR_001'),
  ('WS_044',  '2026-03-01 17:30:00', '2026-03-01 18:10:00', 310, 'Circuit',                    'USR_002'),
  ('WS_045',  '2026-02-28 19:00:00', '2026-02-28 19:50:00', 360, 'Boxing',                     'USR_003'),
  ('WS_046',  '2026-02-27 06:20:00', '2026-02-27 07:05:00', 380, 'Long run',                   'USR_004'),
  ('WS_047',  '2026-02-26 12:10:00', '2026-02-26 12:50:00', 290, 'Row',                        'USR_005'),
  ('WS_048',  '2026-02-25 18:00:00', '2026-02-25 18:45:00', 330, 'Strength',                   'USR_006'),
  ('WS_049',  '2026-02-24 07:30:00', '2026-02-24 08:10:00', 300, 'Recovery',                   'USR_007'),
  ('WS_050',  '2026-02-23 19:15:00', '2026-02-23 19:55:00', 340, 'HIIT',                       'USR_001'),
  ('WS_051',  '2026-02-22 06:45:00', '2026-02-22 07:25:00', 310, 'Tempo run',                  'USR_002'),
  ('WS_052',  '2026-02-21 12:00:00', '2026-02-21 12:40:00', 280, 'Midday bike',                'USR_003'),
  ('WS_053',  '2026-02-20 18:30:00', '2026-02-20 19:10:00', 300, 'Strength',                   'USR_004'),
  ('WS_054',  '2026-02-19 07:00:00', '2026-02-19 07:45:00', 350, 'Intervals',                  'USR_005'),
  ('WS_055',  '2026-02-18 17:45:00', '2026-02-18 18:25:00', 320, 'Circuit',                    'USR_006'),
  ('WS_056',  '2026-02-17 06:15:00', '2026-02-17 07:00:00', 360, 'Run',                        'USR_007'),
  ('WS_057',  '2026-02-16 19:00:00', '2026-02-16 19:45:00', 330, 'Boxing',                     'USR_001'),
  ('WS_058',  '2026-02-15 08:30:00', '2026-02-15 09:10:00', 300, 'Strength',                   'USR_002'),
  ('WS_059',  '2026-02-14 18:00:00', '2026-02-14 18:40:00', 290, 'Evening jog',                'USR_003'),
  ('WS_060',  '2026-02-10 06:20:00', '2026-02-10 07:00:00', 320, 'Run',                        'USR_004'),
  ('WS_061',  '2026-02-05 18:00:00', '2026-02-05 18:45:00', 340, 'Cross training',             'USR_005'),
  ('WS_062',  '2026-02-01 07:00:00', '2026-02-01 07:40:00', 300, 'Intervals',                  'USR_006'),
  ('WS_063',  '2026-01-28 12:30:00', '2026-01-28 13:10:00', 280, 'Lunchtime core',             'USR_007'),
  ('WS_064',  '2026-01-25 19:00:00', '2026-01-25 19:45:00', 360, 'Strength',                   'USR_001'),
  ('WS_065',  '2026-01-20 06:30:00', '2026-01-20 07:20:00', 380, 'Long run',                   'USR_002'),
  ('WS_066',  '2026-01-15 17:00:00', '2026-01-15 17:40:00', 300, 'Tempo',                      'USR_003'),
  ('WS_067',  '2026-01-10 08:00:00', '2026-01-10 08:40:00', 290, 'Yoga',                       'USR_004'),
  ('WS_068',  '2026-01-05 18:30:00', '2026-01-05 19:10:00', 330, 'HIIT',                       'USR_005'),
  ('WS_069',  '2025-12-30 06:15:00', '2025-12-30 07:00:00', 310, 'Recovery run',               'USR_006'),
  ('WS_070',  '2025-12-25 12:00:00', '2025-12-25 12:45:00', 300, 'Boxing',                     'USR_007'),
  ('WS_071',  '2025-12-20 19:00:00', '2025-12-20 19:40:00', 320, 'Strength',                   'USR_001'),
  ('WS_072',  '2025-12-15 07:30:00', '2025-12-15 08:10:00', 300, 'Intervals',                  'USR_002'),
  ('WS_073',  '2025-12-10 17:30:00', '2025-12-10 18:10:00', 340, 'Circuit',                    'USR_003'),
  ('WS_074',  '2025-12-05 06:45:00', '2025-12-05 07:30:00', 380, 'Long ride',                  'USR_004'),
  ('WS_075',  '2025-12-02 18:15:00', '2025-12-02 19:00:00', 350, 'Rowing',                     'USR_005'),
  ('WS_076',  '2025-12-01 07:00:00', '2025-12-01 07:40:00', 290, 'Yoga flow',                  'USR_006'),
  ('WS_077',  '2025-11-28 12:00:00', '2025-11-28 12:45:00', 300, 'Midday HIIT',                'USR_007'),
  ('WS_078',  '2025-11-20 18:00:00', '2025-11-20 18:50:00', 360, 'Strength',                   'USR_001'),
  ('WS_079',  '2025-11-15 06:30:00', '2025-11-15 07:10:00', 310, 'Easy run',                   'USR_002'),
  ('WS_080',  '2025-11-10 19:30:00', '2025-11-10 20:10:00', 330, 'Boxing',                     'USR_003'),
  ('WS_081',  '2025-11-05 08:00:00', '2025-11-05 08:45:00', 350, 'Intervals',                  'USR_004'),
  ('WS_082',  '2025-11-01 17:00:00', '2025-11-01 17:40:00', 300, 'Core',                       'USR_005'),
  ('WS_083',  '2025-10-25 06:15:00', '2025-10-25 07:00:00', 320, 'Run',                        'USR_006'),
  ('WS_084',  '2025-10-20 19:00:00', '2025-10-20 19:40:00', 300, 'Row',                        'USR_007'),
  ('WS_085',  '2025-10-15 07:30:00', '2025-10-15 08:10:00', 310, 'Strength',                   'USR_001'),
  ('WS_086',  '2025-10-10 12:30:00', '2025-10-10 13:10:00', 280, 'Lunchtime ride',             'USR_002'),
  ('WS_087',  '2025-10-05 18:45:00', '2025-10-05 19:25:00', 340, 'HIIT',                       'USR_003'),
  ('WS_088',  '2025-09-30 06:50:00', '2025-09-30 07:30:00', 300, 'Recovery',                   'USR_004'),
  ('WS_089',  '2025-09-25 17:15:00', '2025-09-25 17:55:00', 320, 'Circuit',                    'USR_005'),
  ('WS_090',  '2025-09-20 08:00:00', '2025-09-20 08:40:00', 290, 'Yoga',                       'USR_006'),
  ('WS_091',  '2025-09-15 19:00:00', '2025-09-15 19:45:00', 360, 'Strength',                   'USR_007'),
  ('WS_092',  '2025-09-10 07:10:00', '2025-09-10 07:50:00', 300, 'Run',                        'USR_001'),
  ('WS_093',  '2025-09-05 18:00:00', '2025-09-05 18:40:00', 310, 'Intervals',                  'USR_002'),
  ('WS_094',  '2025-08-30 06:30:00', '2025-08-30 07:10:00', 320, 'Hill repeats',               'USR_003'),
  ('WS_095',  '2025-08-25 12:00:00', '2025-08-25 12:40:00', 280, 'Core & mobility',            'USR_004'),
  ('WS_096',  '2025-08-20 19:30:00', '2025-08-20 20:10:00', 340, 'Boxing',                     'USR_005'),
  ('WS_097',  '2025-08-15 07:00:00', '2025-08-15 07:40:00', 300, 'Recovery',                   'USR_006'),
  ('WS_098',  '2025-08-10 17:45:00', '2025-08-10 18:25:00', 330, 'Circuit',                    'USR_007'),
  ('WS_099',  '2025-08-05 06:20:00', '2025-08-05 07:05:00', 360, 'Long ride',                  'USR_001'),
  ('WS_100',  '2025-08-01 18:00:00', '2025-08-01 18:40:00', 310, 'Rowing',                     'USR_002');

-- ============================================================
-- user_health_goal
-- ============================================================
INSERT INTO user_health_goal (user_id, goal_id) VALUES
  ('USR_001', 'GOAL_002'),
  ('USR_002', 'GOAL_001'),
  ('USR_003', 'GOAL_001'),
  ('USR_004', 'GOAL_003'),
  ('USR_005', 'GOAL_005'),
  ('USR_006', 'GOAL_004'),
  ('USR_007', 'GOAL_002');

-- ============================================================
-- recipe_ingredients
-- ============================================================
INSERT INTO recipe_ingredients (ingredient_id, recipe_id, quantity) VALUES
  ('ING_001', 'RCP_001', 200),
  ('ING_002', 'RCP_001', 150),
  ('ING_006', 'RCP_002', 180),
  ('ING_003', 'RCP_002', 100),
  ('ING_010', 'RCP_002',  50),
  ('ING_007', 'RCP_002',  10),
  ('ING_008', 'RCP_003',  80),
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
-- meal_ingredient
-- ============================================================
INSERT INTO meal_ingredient (ingredient_id, meal_id, quantity) VALUES
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
-- user_organization
-- ============================================================
INSERT INTO user_organization (user_id, organization_id) VALUES
  ('USR_004', 'ORG_001'),
  ('USR_001', 'ORG_002'),
  ('USR_003', 'ORG_003'),
  ('USR_007', 'ORG_005');

-- ============================================================
-- workout_session_exercise
-- ============================================================
INSERT INTO workout_session_exercise (session_id, exercise_id, sets) VALUES
  ('WS_001', 'EXC_001', 4),
  ('WS_001', 'EXC_009', 4),
  ('WS_001', 'EXC_005', 3),
  ('WS_002', 'EXC_007', 3),
  ('WS_003', 'EXC_008', 5),
  ('WS_003', 'EXC_001', 4),
  ('WS_004', 'EXC_004', 1),
  ('WS_004', 'EXC_005', 3),
  ('WS_005', 'EXC_006', 4),
  ('WS_005', 'EXC_009', 4),
  ('WS_006', 'EXC_007', 3),
  ('WS_007', 'EXC_003', 4),
  ('WS_007', 'EXC_002', 4),
  ('WS_008', 'EXC_004', 1),
  ('WS_009', 'EXC_008', 4),
  ('WS_010', 'EXC_001', 4),
  ('WS_010', 'EXC_002', 4),
  ('WS_011', 'EXC_004', 1),
  ('WS_012', 'EXC_007', 3),
  ('WS_013', 'EXC_005', 3),
  ('WS_014', 'EXC_004', 1),
  ('WS_015', 'EXC_005', 3),
  ('WS_016', 'EXC_008', 5),
  ('WS_017', 'EXC_004', 1),
  ('WS_018', 'EXC_003', 4),
  ('WS_019', 'EXC_007', 3),
  ('WS_020', 'EXC_005', 2),
  ('WS_021', 'EXC_004', 1),
  ('WS_022', 'EXC_009', 4),
  ('WS_023', 'EXC_004', 1),
  ('WS_024', 'EXC_010', 6),
  ('WS_025', 'EXC_001', 4),
  ('WS_026', 'EXC_007', 3),
  ('WS_027', 'EXC_002', 4),
  ('WS_028', 'EXC_008', 5),
  ('WS_029', 'EXC_004', 1),
  ('WS_030', 'EXC_005', 3),
  ('WS_031', 'EXC_003', 4),
  ('WS_032', 'EXC_001', 4),
  ('WS_033', 'EXC_008', 4),
  ('WS_034', 'EXC_007', 2),
  ('WS_035', 'EXC_004', 1),
  ('WS_036', 'EXC_010', 6),
  ('WS_037', 'EXC_004', 1),
  ('WS_038', 'EXC_002', 4),
  ('WS_039', 'EXC_009', 4),
  ('WS_040', 'EXC_001', 4),
  ('WS_041', 'EXC_004', 1),
  ('WS_042', 'EXC_008', 5),
  ('WS_043', 'EXC_007', 3),
  ('WS_044', 'EXC_002', 4),
  ('WS_045', 'EXC_006', 4),
  ('WS_046', 'EXC_004', 1),
  ('WS_047', 'EXC_003', 4),
  ('WS_048', 'EXC_009', 4),
  ('WS_049', 'EXC_007', 3),
  ('WS_050', 'EXC_008', 4);

-- ============================================================
-- additional KPI variability seed (mixed activity profiles)
-- ============================================================

INSERT INTO user_ (
  user_id,
  email,
  password_hash,
  first_name,
  last_name,
  birth_date,
  gender_code,
  height_cm,
  current_weight_kg,
  allergies,
  diet_type,
  is_active,
  role_id,
  created_at,
  updated_at
) VALUES
  ('USR_008', 'hugo.bernard@email.com', crypt('Password8!', gen_salt('bf')), 'Hugo', 'Bernard', '1991-03-22', 1, 1.78, 82.30, 'NONE', 'NONE', TRUE, 'ROLE_01', '2024-02-05', '2026-03-22 08:00:00'),
  ('USR_009', 'ines.garnier@email.com', crypt('Password9!', gen_salt('bf')), 'Ines', 'Garnier', '1994-11-09', 2, 1.66, 59.20, 'NONE', 'VEGETARIAN', TRUE, 'ROLE_02', '2024-03-18', '2026-03-22 08:00:00'),
  ('USR_010', 'julien.roche@email.com', crypt('Password10!', gen_salt('bf')), 'Julien', 'Roche', '1987-07-12', 1, 1.84, 88.70, 'MILK', 'NONE', TRUE, 'ROLE_03', '2024-05-01', '2026-03-22 08:00:00'),
  ('USR_011', 'lea.faure@email.com', crypt('Password11!', gen_salt('bf')), 'Lea', 'Faure', '1999-01-31', 2, 1.72, 64.40, 'NUTS', 'PESCATARIAN', TRUE, 'ROLE_01', '2024-06-10', '2026-03-22 08:00:00'),
  ('USR_012', 'marc.rey@email.com', crypt('Password12!', gen_salt('bf')), 'Marc', 'Rey', '1983-09-03', 1, 1.75, 91.10, 'NONE', 'KETO', FALSE, 'ROLE_04', '2024-01-25', '2026-03-22 08:00:00'),
  ('USR_013', 'nina.laurent@email.com', crypt('Password13!', gen_salt('bf')), 'Nina', 'Laurent', '1993-05-11', 2, 1.69, 66.00, 'NONE', 'NONE', TRUE, 'ROLE_01', '2024-02-14', '2026-03-22 08:00:00'),
  ('USR_014', 'omar.morel@email.com', crypt('Password14!', gen_salt('bf')), 'Omar', 'Morel', '1986-10-27', 1, 1.80, 79.30, 'NONE', 'NONE', TRUE, 'ROLE_02', '2024-03-03', '2026-03-22 08:00:00');

INSERT INTO user_health_goal (user_id, goal_id) VALUES
  ('USR_008', 'GOAL_003'),
  ('USR_009', 'GOAL_005'),
  ('USR_010', 'GOAL_002'),
  ('USR_011', 'GOAL_001'),
  ('USR_012', 'GOAL_004'),
  ('USR_013', 'GOAL_005'),
  ('USR_014', 'GOAL_003');

INSERT INTO login_history (last_login_id, user_id, last_login) VALUES
  -- Active in current 7d and previous windows
  ('LOG_035', 'USR_008', '2026-03-21 07:40:00'),
  ('LOG_036', 'USR_008', '2026-03-18 19:35:00'),
  ('LOG_037', 'USR_008', '2026-03-09 08:20:00'),
  ('LOG_038', 'USR_008', '2026-02-25 21:10:00'),

  -- Active in 30d/90d but not in current 7d
  ('LOG_039', 'USR_009', '2026-03-13 10:05:00'),
  ('LOG_040', 'USR_009', '2026-03-02 18:15:00'),
  ('LOG_041', 'USR_009', '2026-02-20 08:45:00'),

  -- Active in previous windows only, absent in current 30d
  ('LOG_042', 'USR_010', '2026-02-18 07:55:00'),
  ('LOG_043', 'USR_010', '2026-01-28 20:30:00'),

  -- Long-tail user: contributes to churn baseline
  ('LOG_044', 'USR_011', '2025-12-10 09:10:00'),

  -- Inactive recent but seen historically
  ('LOG_045', 'USR_012', '2025-11-05 11:25:00'),

  -- Active login without workout in current 30d window (reduces current engagement)
  ('LOG_046', 'USR_011', '2026-03-10 08:55:00'),

  -- Active login without workout in previous 30d window (reduces compared engagement)
  ('LOG_047', 'USR_012', '2026-02-10 20:20:00'),

  -- Active in current 7d without workout (reduces 7d engagement from 100)
  ('LOG_048', 'USR_011', '2026-03-22 09:40:00'),

  -- Seen before 90d and active in previous 90d only (creates non-zero current 90d churn)
  ('LOG_049', 'USR_014', '2025-11-20 17:25:00');

INSERT INTO workout_session (session_id, start_at, end_at, calories_burned, notes, user_id) VALUES
  -- Current 7d workouts
  ('WS_101', '2026-03-21 07:00:00', '2026-03-21 07:55:00', 390, 'Progressive run', 'USR_008'),
  ('WS_102', '2026-03-20 18:20:00', '2026-03-20 19:05:00', 340, 'Lower body session', 'USR_009'),
  ('WS_103', '2026-03-18 06:40:00', '2026-03-18 07:30:00', 370, 'Intervals', 'USR_008'),

  -- Previous 7d workouts (used for trend comparison)
  ('WS_104', '2026-03-12 19:00:00', '2026-03-12 19:35:00', 260, 'Recovery mobility', 'USR_010'),
  ('WS_105', '2026-03-11 07:10:00', '2026-03-11 07:50:00', 300, 'Easy cardio', 'USR_009'),

  -- 30d/90d historical workouts
  ('WS_106', '2026-02-24 18:10:00', '2026-02-24 19:00:00', 360, 'Strength', 'USR_010'),
  ('WS_107', '2026-02-19 06:50:00', '2026-02-19 07:30:00', 280, 'Tempo', 'USR_009'),
  ('WS_108', '2026-01-30 17:30:00', '2026-01-30 18:15:00', 320, 'Circuit', 'USR_011');

INSERT INTO workout_session_exercise (session_id, exercise_id, sets) VALUES
  ('WS_101', 'EXC_004', 1),
  ('WS_101', 'EXC_010', 5),
  ('WS_102', 'EXC_002', 4),
  ('WS_102', 'EXC_005', 3),
  ('WS_103', 'EXC_008', 4),
  ('WS_104', 'EXC_007', 3),
  ('WS_105', 'EXC_004', 1),
  ('WS_106', 'EXC_009', 4),
  ('WS_107', 'EXC_001', 4),
  ('WS_108', 'EXC_003', 4);

-- ============================================================
-- v8 minimal delta: dynamic nutrition + biometric analytics coverage
-- ============================================================

INSERT INTO meal (meal_id, consumed_at, quantity_grams, calories_consumed, user_id) VALUES
  ('MEAL_101', now() - interval '1 day' + interval '08:20:00', 360, 520, 'USR_001'),
  ('MEAL_102', now() - interval '2 days' + interval '12:50:00', 410, 650, 'USR_003'),
  ('MEAL_103', now() - interval '3 days' + interval '19:10:00', 330, 540, 'USR_005'),
  ('MEAL_104', now() - interval '4 days' + interval '16:30:00', 190, 260, 'USR_002'),
  ('MEAL_105', now() - interval '8 days' + interval '08:10:00', 420, 590, 'USR_001'),
  ('MEAL_106', now() - interval '10 days' + interval '12:35:00', 470, 710, 'USR_003'),
  ('MEAL_107', now() - interval '36 days' + interval '19:05:00', 360, 640, 'USR_004'),
  ('MEAL_108', now() - interval '42 days' + interval '16:20:00', 210, 290, 'USR_002'),
  ('MEAL_109', now() - interval '50 days' + interval '07:45:00', 340, 480, 'USR_007'),
  ('MEAL_110', now() - interval '58 days' + interval '13:10:00', 430, 670, 'USR_005'),
  ('MEAL_111', now() - interval '110 days' + interval '12:10:00', 450, 760, 'USR_003'),
  ('MEAL_112', now() - interval '140 days' + interval '20:15:00', 390, 610, 'USR_001')
ON CONFLICT (meal_id) DO UPDATE
SET
  consumed_at = EXCLUDED.consumed_at,
  quantity_grams = EXCLUDED.quantity_grams,
  calories_consumed = EXCLUDED.calories_consumed,
  user_id = EXCLUDED.user_id;

INSERT INTO meal_ingredient (ingredient_id, meal_id, quantity) VALUES
  ('ING_008', 'MEAL_101', 85), ('ING_009', 'MEAL_101', 120),
  ('ING_001', 'MEAL_102', 170), ('ING_003', 'MEAL_102', 105),
  ('ING_006', 'MEAL_103', 150), ('ING_010', 'MEAL_103', 100),
  ('ING_008', 'MEAL_104', 60), ('ING_005', 'MEAL_104', 70),
  ('ING_001', 'MEAL_105', 160), ('ING_003', 'MEAL_105', 100),
  ('ING_001', 'MEAL_106', 180), ('ING_002', 'MEAL_106', 120),
  ('ING_006', 'MEAL_107', 170), ('ING_010', 'MEAL_107', 100),
  ('ING_008', 'MEAL_108', 70), ('ING_005', 'MEAL_108', 60),
  ('ING_009', 'MEAL_109', 160), ('ING_005', 'MEAL_109', 90),
  ('ING_003', 'MEAL_110', 140), ('ING_001', 'MEAL_110', 150),
  ('ING_001', 'MEAL_111', 210), ('ING_003', 'MEAL_111', 120),
  ('ING_006', 'MEAL_112', 150), ('ING_008', 'MEAL_112', 90)
ON CONFLICT (ingredient_id, meal_id) DO UPDATE
SET quantity = EXCLUDED.quantity;

INSERT INTO user_metrics (
  metric_id,
  user_id,
  recorded_date,
  weight_kg,
  body_fat_pourcentage,
  steps,
  calories_burned,
  heart_rate_avg,
  heart_rate_max,
  sleep_hours
) VALUES
  ('MET_101', 'USR_001', now() - interval '1 day' + interval '07:00:00', 77.60, 17.9, 11800, 640.0, 65, 155, 8),
  ('MET_102', 'USR_002', now() - interval '2 days' + interval '07:05:00', 60.90, 21.3, 10100, 530.0, 68, 150, 7),
  ('MET_103', 'USR_003', now() - interval '3 days' + interval '07:10:00', 93.50, 27.0, 8000, 720.0, 75, 164, 6),
  ('MET_104', 'USR_005', now() - interval '4 days' + interval '07:20:00', 69.60, 23.5, 9300, 580.0, 70, 157, 7),
  ('MET_105', 'USR_001', now() - interval '8 days' + interval '07:00:00', 77.80, 18.0, 11200, 620.0, 66, 154, 8),
  ('MET_106', 'USR_003', now() - interval '10 days' + interval '07:10:00', 93.80, 27.2, 7600, 700.0, 76, 163, 6),
  ('MET_107', 'USR_001', now() - interval '36 days' + interval '07:00:00', 78.40, 18.4, 9600, 540.0, 69, 150, 7),
  ('MET_108', 'USR_002', now() - interval '42 days' + interval '07:05:00', 61.70, 21.9, 8600, 470.0, 72, 151, 6),
  ('MET_109', 'USR_003', now() - interval '50 days' + interval '07:10:00', 95.00, 27.9, 6500, 630.0, 80, 166, 6),
  ('MET_110', 'USR_004', now() - interval '58 days' + interval '07:15:00', 54.80, 14.9, 11700, 390.0, 63, 145, 8),
  ('MET_111', 'USR_001', now() - interval '110 days' + interval '07:00:00', 79.20, 18.9, 8700, 490.0, 72, 154, 6),
  ('MET_112', 'USR_005', now() - interval '140 days' + interval '07:20:00', 71.30, 24.6, 7600, 510.0, 75, 160, 6)
ON CONFLICT (metric_id) DO UPDATE
SET
  user_id = EXCLUDED.user_id,
  recorded_date = EXCLUDED.recorded_date,
  weight_kg = EXCLUDED.weight_kg,
  body_fat_pourcentage = EXCLUDED.body_fat_pourcentage,
  steps = EXCLUDED.steps,
  calories_burned = EXCLUDED.calories_burned,
  heart_rate_avg = EXCLUDED.heart_rate_avg,
  heart_rate_max = EXCLUDED.heart_rate_max,
  sleep_hours = EXCLUDED.sleep_hours;