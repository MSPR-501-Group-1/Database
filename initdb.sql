-- ============================================================
--  Schéma PostgreSQL — Application Santé & Fitness
--  Généré et corrigé pour PostgreSQL
-- ============================================================

-- Extensions utiles
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ------------------------------------------------------------
-- Tables de référence / dictionnaires
-- ------------------------------------------------------------

CREATE TABLE health_goal (
    goal_id     VARCHAR(50) PRIMARY KEY,
    label       VARCHAR(50),
    description VARCHAR(255)
);

CREATE TABLE subscription_plan (
    plan_id         VARCHAR(50) PRIMARY KEY,
    name            VARCHAR(50),
    monthly_price   NUMERIC(10,2),
    duration_months INT,
    features_json   JSONB,
    is_active       BOOLEAN DEFAULT TRUE
);

CREATE TABLE food (
    food_id          VARCHAR(50) PRIMARY KEY,
    name             VARCHAR(100),
    brand            VARCHAR(100),
    calories_100g    NUMERIC(8,2),
    fat_100g         NUMERIC(8,2),
    nutriscore       INT,
    category_ref     VARCHAR(50),
    fiber_g          NUMERIC(8,2),
    sugar_g          NUMERIC(8,2),
    sodium_mg        NUMERIC(8,2),
    cholesterol_mg   NUMERIC(8,2),
    protein_100g     NUMERIC(8,2),
    carbs_100g       NUMERIC(8,2)
);

CREATE TABLE activity_type (
    activity_id VARCHAR(50) PRIMARY KEY,
    name        VARCHAR(100),
    met_value   NUMERIC(5,2),
    icon_url    VARCHAR(255)
);

CREATE TABLE exercise (
    exercise_id        VARCHAR(50) PRIMARY KEY,
    name               VARCHAR(100),
    body_part_target   VARCHAR(100),
    video_url          VARCHAR(255),
    description        TEXT,
    difficulty_level   INT,
    equipment_required VARCHAR(100),
    category           VARCHAR(50)
);

-- ------------------------------------------------------------
-- ETL / Qualité des données
-- ------------------------------------------------------------

CREATE TABLE data_source (
    source_id        VARCHAR(50) PRIMARY KEY,
    source_name      VARCHAR(100),
    source_type      VARCHAR(50),
    format           VARCHAR(50),
    source_url       VARCHAR(255),
    expected_records INT,
    last_updated     TIMESTAMP,
    is_active        BOOLEAN DEFAULT TRUE
);

CREATE TABLE etl_execution (
    execution_id      VARCHAR(50) PRIMARY KEY,
    started_at        TIMESTAMP,
    ended_at          TIMESTAMP,
    status            VARCHAR(20),
    records_extracted INT,
    records_loaded    INT,
    records_rejected  INT,
    error_message     TEXT,
    triggered_by      VARCHAR(100),
    source_id         VARCHAR(50) NOT NULL REFERENCES data_source(source_id)
);

CREATE TABLE data_quality_check (
    check_id         VARCHAR(50) PRIMARY KEY,
    target_table     VARCHAR(100),
    check_type       VARCHAR(50),
    check_rule       TEXT,
    records_checked  INT,
    records_failed   INT,
    checked_at       TIMESTAMP,
    status           VARCHAR(20),
    execution_id     VARCHAR(50) NOT NULL REFERENCES etl_execution(execution_id)
);

CREATE TABLE data_anomaly (
    anomaly_id         VARCHAR(50) PRIMARY KEY,
    source_table       VARCHAR(100),
    anomaly_type       VARCHAR(100),
    field_name         VARCHAR(100),
    record_identifier  VARCHAR(100),
    original_value     TEXT,
    detected_at        TIMESTAMP,
    severity           VARCHAR(20),
    is_resolved        BOOLEAN DEFAULT FALSE,
    resolution_action  TEXT,
    check_id           VARCHAR(50) REFERENCES data_quality_check(check_id),
    execution_id       VARCHAR(50) NOT NULL REFERENCES etl_execution(execution_id)
);

-- ------------------------------------------------------------
-- Utilisateurs & Profils
-- ------------------------------------------------------------

CREATE TABLE user_profile (
    profile_id          VARCHAR(50) PRIMARY KEY,
    height_cm           INT,
    current_weight_kg   NUMERIC(5,2),
    activity_level_ref  VARCHAR(50),
    allergies_json      JSONB,
    preferences_json    JSONB,
    updated_at          TIMESTAMP,
    goal_id             VARCHAR(50) REFERENCES health_goal(goal_id)
);

CREATE TABLE user_ (
    user_id         VARCHAR(50) PRIMARY KEY,
    email           VARCHAR(100) UNIQUE NOT NULL,
    password_hash   VARCHAR(255),
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    birth_date      DATE,
    gender_code     INT,
    created_at      TIMESTAMP DEFAULT NOW(),
    is_active       BOOLEAN DEFAULT TRUE,
    role_code       VARCHAR(20) DEFAULT 'USER',
    profile_id VARCHAR(50) UNIQUE REFERENCES user_profile(profile_id)
);

-- ------------------------------------------------------------
-- Abonnements & Facturation
-- ------------------------------------------------------------

CREATE TABLE subscription (
    subscription_id VARCHAR(50) PRIMARY KEY,
    start_date      DATE,
    end_date        DATE,
    status          VARCHAR(20),
    auto_renew      BOOLEAN DEFAULT FALSE,
    plan_id         VARCHAR(50) NOT NULL REFERENCES subscription_plan(plan_id),
    user_id         VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE invoice (
    invoice_id      VARCHAR(50) PRIMARY KEY,
    issued_at       TIMESTAMP,
    total_amount    NUMERIC(10,2),
    status          VARCHAR(20),
    pdf_url         VARCHAR(255),
    subscription_id VARCHAR(50) REFERENCES subscription(subscription_id),
    user_id         VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE payment_transaction (
    transaction_id      VARCHAR(50) PRIMARY KEY,
    processed_at        TIMESTAMP,
    amount              NUMERIC(10,2),
    payment_method      VARCHAR(50),
    transaction_ref_ext VARCHAR(100),
    status              VARCHAR(20),
    invoice_id          VARCHAR(50) NOT NULL REFERENCES invoice(invoice_id)
);

-- ------------------------------------------------------------
-- Alimentation
-- ------------------------------------------------------------

CREATE TABLE recipe (
    recipe_id          VARCHAR(50) PRIMARY KEY,
    title              VARCHAR(100),
    instructions       TEXT,
    prep_time_min      INT,
    difficulty         INT,
    created_by_user    BOOLEAN DEFAULT FALSE,
    user_id            VARCHAR(50) REFERENCES user_(user_id)
);

CREATE TABLE recipe_ingredient (
    link_id        VARCHAR(50) PRIMARY KEY,
    quantity_grams NUMERIC(8,2),
    recipe_id      VARCHAR(50) NOT NULL REFERENCES recipe(recipe_id),
    food_id        VARCHAR(50) NOT NULL REFERENCES food(food_id)
);

CREATE TABLE food_diary_entry (
    entry_id          VARCHAR(50) PRIMARY KEY,
    consumed_at       TIMESTAMP,
    quantity_grams    NUMERIC(8,2),
    meal_type         VARCHAR(20),
    calories_consumed NUMERIC(8,2),
    food_id           VARCHAR(50) NOT NULL REFERENCES food(food_id),
    user_id           VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

-- ------------------------------------------------------------
-- Activité physique
-- ------------------------------------------------------------

CREATE TABLE workout_session (
    session_id     VARCHAR(50) PRIMARY KEY,
    start_time     TIMESTAMP,
    duration_min   INT,
    calories_burned NUMERIC(8,2),
    notes          TEXT,
    distance_km    NUMERIC(8,2),
    activity_id    VARCHAR(50) NOT NULL REFERENCES activity_type(activity_id),
    user_id        VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE session_detail (
    detail_id   VARCHAR(50) PRIMARY KEY,
    sets        INT,
    reps        INT,
    weight_kg   NUMERIC(6,2),
    exercise_id VARCHAR(50) NOT NULL REFERENCES exercise(exercise_id),
    session_id  VARCHAR(50) NOT NULL REFERENCES workout_session(session_id)
);

-- ------------------------------------------------------------
-- Appareils connectés & Métriques
-- ------------------------------------------------------------

CREATE TABLE connected_device (
    device_id   VARCHAR(50) PRIMARY KEY,
    device_name VARCHAR(100),
    device_type VARCHAR(50),
    last_synced TIMESTAMP,
    is_active   BOOLEAN DEFAULT TRUE,
    user_id     VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE biometric_measure (
    measure_id  VARCHAR(50) PRIMARY KEY,
    type        VARCHAR(50),
    value_      NUMERIC(10,2),
    measured_at TIMESTAMP,
    device_id   VARCHAR(50) REFERENCES connected_device(device_id),
    user_id     VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE user_metrics (
    metric_id            VARCHAR(50) PRIMARY KEY,
    recorded_date        DATE,
    weight_kg            NUMERIC(5,2),
    body_fat_percentage  NUMERIC(5,2),
    steps                INT,
    calories_burned      NUMERIC(8,2),
    heart_rate_avg       INT,
    heart_rate_max       INT,
    sleep_hours          NUMERIC(4,2),
    created_at           TIMESTAMP DEFAULT NOW(),
    user_id              VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

-- ------------------------------------------------------------
-- Suivi & Recommandations
-- ------------------------------------------------------------

CREATE TABLE progress_tracker (
    progress_id             VARCHAR(50) PRIMARY KEY,
    weight_kg               NUMERIC(5,2),
    body_fat_percentage     NUMERIC(5,2),
    weekly_calories_avg     NUMERIC(8,2),
    created_at              TIMESTAMP DEFAULT NOW(),
    goal_achievement_json   JSONB,
    weekly_workouts_count   INT,
    tracking_date           DATE,
    user_id                 VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE ai_recommendation (
    recommendation_id VARCHAR(50) PRIMARY KEY,
    generated_at      TIMESTAMP,
    category          VARCHAR(50),
    title             VARCHAR(100),
    content_text      TEXT,
    confidence_score  NUMERIC(4,3),
    is_viewed         BOOLEAN DEFAULT FALSE,
    feedback_rating   NUMERIC(3,2),
    user_id           VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

CREATE TABLE diet_recommendation (
    recommendation_id  VARCHAR(50) PRIMARY KEY,
    meal_type          VARCHAR(20),
    recommended_foods  TEXT,
    total_calories     INT,
    protein_g          NUMERIC(8,2),
    carbs_g            NUMERIC(8,2),
    fat_g              NUMERIC(8,2),
    diet_type          VARCHAR(50),
    generated_at       TIMESTAMP,
    is_followed        BOOLEAN DEFAULT FALSE,
    user_id            VARCHAR(50) NOT NULL REFERENCES user_(user_id)
);

-- ============================================================
-- Index recommandés pour les performances
-- ============================================================

CREATE INDEX idx_user_email              ON user_(email);
CREATE INDEX idx_food_diary_user         ON food_diary_entry(user_id, consumed_at);
CREATE INDEX idx_workout_session_user    ON workout_session(user_id, start_time);
CREATE INDEX idx_biometric_user         ON biometric_measure(user_id, measured_at);
CREATE INDEX idx_user_metrics_user      ON user_metrics(user_id, recorded_date);
CREATE INDEX idx_subscription_user      ON subscription(user_id);
CREATE INDEX idx_etl_execution_source   ON etl_execution(source_id);
CREATE INDEX idx_anomaly_execution      ON data_anomaly(execution_id);