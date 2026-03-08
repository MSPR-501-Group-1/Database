-- ============================================================
-- HEALTHAI COACH — Script d'initialisation PostgreSQL
-- Généré depuis Looping + corrections types & ENUMs
-- ============================================================

-- Extension UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- ENUMS
-- ============================================================

CREATE TYPE billing_cycle_enum AS ENUM (
    'MONTHLY', 'QUARTERLY', 'ANNUAL', 'LIFETIME'
);

CREATE TYPE feature_category_enum AS ENUM (
    'NUTRITION', 'FITNESS', 'ANALYTICS', 'IA', 'ADMIN', 'INTEGRATION', 'SOCIAL'
);

CREATE TYPE role_type_enum AS ENUM (
    'FREEMIUM', 'PREMIUM', 'PREMIUM_PLUS', 'B2B', 'ADMIN',
    'USER', 'B2B_ADMIN', 'NUTRITIONIST', 'MODERATOR'
);

CREATE TYPE subscription_status_enum AS ENUM (
    'TRIAL', 'ACTIVE', 'PAUSED', 'CANCELLED', 'EXPIRED',
    'PENDING_PAYMENT', 'PAST_DUE'
);

CREATE TYPE cancellation_reason_enum AS ENUM (
    'USER_REQUEST', 'PAYMENT_FAILURE', 'ADMIN', 'FRAUD', 'OTHER'
);

CREATE TYPE transaction_status_enum AS ENUM (
    'PENDING', 'PROCESSING', 'SUCCEEDED', 'FAILED',
    'REFUNDED', 'PARTIALLY_REFUNDED', 'DISPUTED', 'CANCELLED'
);

CREATE TYPE org_type_enum AS ENUM (
    'COMPANY', 'GYM', 'MUTUAL', 'NGO', 'OTHER'
);



CREATE TYPE sub_event_type_enum AS ENUM (
    'CREATED', 'UPGRADED', 'DOWNGRADED', 'RENEWED', 'PAUSED',
    'RESUMED', 'CANCELLED', 'REACTIVATED', 'TRIAL_STARTED',
    'TRIAL_CONVERTED', 'PAYMENT_FAILED', 'PLAN_CHANGED'
);

-- ============================================================
-- MODULE SANTÉ — Tables indépendantes
-- ============================================================

CREATE TABLE health_goal(
    goal_id         VARCHAR(50),
    label           VARCHAR(50),
    description     VARCHAR(50),
    PRIMARY KEY(goal_id)
);

CREATE TABLE ingredients(
    ingredients_id  VARCHAR(50),
    name            VARCHAR(50),
    brand           VARCHAR(50),
    calories_100g   DECIMAL(15,2),
    fat_100g        DECIMAL(15,2),
    nutriscore      INT,
    category_ref    VARCHAR(50),
    fiber_g         DECIMAL(15,2),
    sugar_g         DECIMAL(15,2),
    sodium_mg       DECIMAL(15,2),
    cholesterol_mg  DECIMAL(15,2),
    protein_100g    DECIMAL(15,2),
    carbs_100g      DECIMAL(15,2),
    PRIMARY KEY(ingredients_id)
);

CREATE TABLE recipe(
    recipe_id           VARCHAR(50),
    title               VARCHAR(50),
    instructions        TEXT,               -- TEXT plutôt que VARCHAR(50)
    prep_time_min       INT,                -- COUNTER → INT
    difficulty          INT,
    created_by_user_id  BOOLEAN,            -- LOGICAL → BOOLEAN
    PRIMARY KEY(recipe_id)
);

CREATE TABLE activity_type(
    activity_id VARCHAR(50),
    name        VARCHAR(50),
    met_value   INT,
    icon_url    VARCHAR(200),               -- agrandi pour une URL
    PRIMARY KEY(activity_id)
);

CREATE TABLE exercise(
    exercise_id         VARCHAR(50),
    name                VARCHAR(50),
    body_part_target    VARCHAR(50),
    video_url           VARCHAR(200),       -- agrandi pour une URL
    description         TEXT,
    difficulty_level    INT,
    equipment_required  VARCHAR(50),
    category            VARCHAR(50),
    PRIMARY KEY(exercise_id)
);

CREATE TABLE connected_device(
    device_id   VARCHAR(50),
    device_name VARCHAR(50),
    device_type VARCHAR(50),
    last_synch  DATE,
    is_active   BOOLEAN,                    -- LOGICAL → BOOLEAN
    PRIMARY KEY(device_id)
);

CREATE TABLE user_metrics(
    metric_id               VARCHAR(50),
    recorded_date           DATE,
    weight_kg               DECIMAL(15,2),
    body_fat_pourcentage    INT,
    steps                   INT,
    calories_burned         DECIMAL(15,2),
    heart_rate_avg          INT,
    heart_rate_max          INT,
    sleep_hours             INT,
    created_at              TIMESTAMP,      -- DATETIME → TIMESTAMP
    PRIMARY KEY(metric_id)
);

-- ============================================================
-- MODULE ETL
-- ============================================================

CREATE TABLE data_source(
    source_id        VARCHAR(50),
    source_name      VARCHAR(50),
    source_type      VARCHAR(50),
    format           VARCHAR(50),
    source_url       VARCHAR(200),
    expected_records VARCHAR(50),
    last_updates     TIMESTAMP,             -- DATETIME → TIMESTAMP
    is_active        BOOLEAN,               -- LOGICAL → BOOLEAN
    PRIMARY KEY(source_id)
);

CREATE TABLE etl_execution(
    execution_id        VARCHAR(50),
    started_at          TIMESTAMP,          -- DATETIME → TIMESTAMP
    ended_at            TIMESTAMP,
    status              BOOLEAN,
    records_extracted   INT,                -- LOGICAL → INT (un nombre, pas un booléen)
    records_loaded      INT,
    records_rejected    INT,
    error_message       TEXT,
    triggered_by        VARCHAR(50),
    source_id           VARCHAR(50) NOT NULL,
    PRIMARY KEY(execution_id),
    FOREIGN KEY(source_id) REFERENCES data_source(source_id)
);

CREATE TABLE data_quality_check_(
    check_id        VARCHAR(50),
    target_table    VARCHAR(50),
    check_type      VARCHAR(50),
    check_rule      VARCHAR(50),
    records_checked INT,
    records_failed  INT,
    checked_at      TIMESTAMP,
    status          BOOLEAN,
    execution_id    VARCHAR(50) NOT NULL,
    PRIMARY KEY(check_id),
    FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

CREATE TABLE data_anomaly(
    anomaly_id          VARCHAR(50),
    source_table        VARCHAR(50),
    anomaly_table       VARCHAR(50),
    field_name          VARCHAR(50),
    record_identifier   VARCHAR(50),
    original_value      VARCHAR(50),
    detected_at         TIMESTAMP,
    severity            VARCHAR(50),
    is_resolved         BOOLEAN,
    resolution_action   VARCHAR(50),
    check_id            VARCHAR(50),
    execution_id        VARCHAR(50) NOT NULL,
    PRIMARY KEY(anomaly_id),
    FOREIGN KEY(check_id)    REFERENCES data_quality_check_(check_id),
    FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

-- ============================================================
-- MODULE ABONNEMENTS — Tables indépendantes
-- ============================================================

CREATE TABLE feature(
    feature_id  VARCHAR(50),
    name        VARCHAR(150),
    description TEXT,
    category    feature_category_enum NOT NULL,  -- ENUM
    PRIMARY KEY(feature_id)
);

CREATE TABLE role(
    role_id     VARCHAR(50),
    role_type   role_type_enum NOT NULL,          -- ENUM
    is_system   BOOLEAN DEFAULT FALSE,            -- LOGICAL → BOOLEAN
    PRIMARY KEY(role_id)
);


CREATE TABLE organization(
    organization_id VARCHAR(50),
    name            VARCHAR(200) NOT NULL,
    org_type        org_type_enum NOT NULL,       -- ENUM
    domain          VARCHAR(200),
    PRIMARY KEY(organization_id)
);

-- ============================================================
-- MODULE UTILISATEURS
-- ============================================================

CREATE TABLE user_profile(
    profile_id          VARCHAR(50),
    height_cm           INT,
    current_weight_kg   DECIMAL(5,2),             -- agrandi (3,2 trop petit)
    activity_level_ref  VARCHAR(50),
    allergies_json      TEXT,                     -- TEXT pour du JSON
    preferences_json    TEXT,
    updated_at          TIMESTAMP,
    goal_id             VARCHAR(50),
    PRIMARY KEY(profile_id),
    FOREIGN KEY(goal_id) REFERENCES health_goal(goal_id)
);

CREATE TABLE user_(
    user_id         VARCHAR(50),
    email           VARCHAR(100) UNIQUE,          -- UNIQUE + taille réaliste
    password_hash   VARCHAR(255),                 -- hash bcrypt = 60 chars min
    first_name      VARCHAR(50),
    last_name       VARCHAR(50),
    birth_date      DATE,
    gender_code     INT,
    created_at      TIMESTAMP DEFAULT NOW(),
    is_active       BOOLEAN DEFAULT TRUE,         -- LOGICAL → BOOLEAN
    role_id         VARCHAR(50) NOT NULL,
    profile_id      VARCHAR(50) NOT NULL,
    PRIMARY KEY(user_id),
    UNIQUE(profile_id),
    FOREIGN KEY(role_id)    REFERENCES role(role_id),
    FOREIGN KEY(profile_id) REFERENCES user_profile(profile_id)
);

-- ============================================================
-- MODULE ABONNEMENTS — Tables dépendantes
-- ============================================================

CREATE TABLE subscription_plan(
    plan_id         VARCHAR(50),
    name            VARCHAR(100) NOT NULL,
    description     TEXT,
    billing_cycle   billing_cycle_enum NOT NULL,  -- ENUM
    price_ht        DECIMAL(10,2) NOT NULL,
    is_public       BOOLEAN DEFAULT TRUE,         -- LOGICAL → BOOLEAN
    created_at      TIMESTAMP DEFAULT NOW(),
    updated_at      TIMESTAMP DEFAULT NOW(),
    role_id         VARCHAR(50) NOT NULL,
    PRIMARY KEY(plan_id),
    FOREIGN KEY(role_id) REFERENCES role(role_id)
);



CREATE TABLE subscription(
    subscription_id     VARCHAR(50),
    start_date          TIMESTAMP NOT NULL,
    end_date            TIMESTAMP,
    status              subscription_status_enum NOT NULL,  -- ENUM
    cancelled_at        TIMESTAMP,
    cancellation_reason cancellation_reason_enum,           -- ENUM
    created_at          TIMESTAMP DEFAULT NOW(),
    updated_at          TIMESTAMP DEFAULT NOW(),
    user_id             VARCHAR(50) NOT NULL,
    plan_id             VARCHAR(50) NOT NULL,
    PRIMARY KEY(subscription_id),
    FOREIGN KEY(user_id)  REFERENCES user_(user_id),
    FOREIGN KEY(plan_id)  REFERENCES subscription_plan(plan_id)
);

CREATE TABLE subscription_history(
    history_id          VARCHAR(50),
    event_type          sub_event_type_enum NOT NULL,   -- ENUM (renommé status_event)
    previous_role       VARCHAR(50),
    new_role            VARCHAR(50),
    occurred_at         TIMESTAMP DEFAULT NOW(),        -- renommé occurred_at_
    previous_plan_id    VARCHAR(50),                    -- renommé plan_id
    new_plan_id         VARCHAR(50),                    -- renommé plan_id_1
    user_id             VARCHAR(50) NOT NULL,
    subscription_id     VARCHAR(50) NOT NULL,
    PRIMARY KEY(history_id),
    FOREIGN KEY(previous_plan_id) REFERENCES subscription_plan(plan_id),
    FOREIGN KEY(new_plan_id)      REFERENCES subscription_plan(plan_id),
    FOREIGN KEY(user_id)          REFERENCES user_(user_id),
    FOREIGN KEY(subscription_id)  REFERENCES subscription(subscription_id)
);

CREATE TABLE payment_transaction(
    transaction_id  VARCHAR(50),
    processed_at    TIMESTAMP,                          -- DATETIME → TIMESTAMP
    amount_ht       DECIMAL(12,4) NOT NULL,             -- CURRENCY → DECIMAL
    status          transaction_status_enum NOT NULL,   -- ENUM (LOGICAL → ENUM)
    created_at      TIMESTAMP DEFAULT NOW(),
    subscription_id VARCHAR(50) NOT NULL,
    PRIMARY KEY(transaction_id),
    FOREIGN KEY(subscription_id) REFERENCES subscription(subscription_id)
);

-- ============================================================
-- MODULE SANTÉ — Tables dépendantes de user_
-- ============================================================

CREATE TABLE ingredients_ate(
    entry_id            VARCHAR(50),
    consumed_at         DATE,
    quantity_grams      INT,
    meal_type           BOOLEAN,
    calories_consumed   INT,
    user_id             VARCHAR(50) NOT NULL,
    PRIMARY KEY(entry_id),
    FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE workout_session(
    session_id      VARCHAR(50),
    start_time      TIMESTAMP,                          -- DATE → TIMESTAMP
    duration_time   INT,                                -- COUNTER → INT (minutes)
    calories_burned INT,
    notes           TEXT,
    distance_km     DECIMAL(15,2),
    activity_id     VARCHAR(50) NOT NULL,
    user_id         VARCHAR(50) NOT NULL,
    PRIMARY KEY(session_id),
    FOREIGN KEY(activity_id) REFERENCES activity_type(activity_id),
    FOREIGN KEY(user_id)     REFERENCES user_(user_id)
);

CREATE TABLE session_detail(
    detail_id   VARCHAR(50),
    sets        INT,
    reps        INT,
    weight_kg   DECIMAL(5,2),                           -- INT → DECIMAL (poids avec décimales)
    exercise_id VARCHAR(50) NOT NULL,
    session_id  VARCHAR(50) NOT NULL,
    PRIMARY KEY(detail_id),
    FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id),
    FOREIGN KEY(session_id)  REFERENCES workout_session(session_id)
);

CREATE TABLE biometric_measure(
    measure_id  VARCHAR(50),
    type        VARCHAR(50),
    value_      DECIMAL(10,2),                          -- INT → DECIMAL (mesures précises)
    measured_at TIMESTAMP,
    user_id     VARCHAR(50) NOT NULL,
    PRIMARY KEY(measure_id),
    FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE ai_recommendation(
    recommendation_id   VARCHAR(50),
    generated_at        TIMESTAMP,
    category            VARCHAR(50),
    title               VARCHAR(100),
    content_text        TEXT,                           -- VARCHAR(200) → TEXT
    confidence_score    DECIMAL(5,2),
    is_viewed           BOOLEAN DEFAULT FALSE,
    feedback_rating     DECIMAL(3,2),
    user_id             VARCHAR(50) NOT NULL,
    PRIMARY KEY(recommendation_id),
    FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE diet_recommendation(
    recommendation_id   VARCHAR(50),
    meal_type           VARCHAR(50),                    -- LOGICAL → VARCHAR (matin/midi/soir)
    recommended_foods   TEXT,
    total_calories      INT,
    protein_g           INT,
    carbs_g             INT,
    fat_g               INT,
    diet_type           VARCHAR(50),                    -- LOGICAL → VARCHAR
    generated_at        TIMESTAMP,
    is_followed         BOOLEAN DEFAULT FALSE,
    user_id             VARCHAR(50) NOT NULL,
    PRIMARY KEY(recommendation_id),
    FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

-- ============================================================
-- TABLES D'ASSOCIATION
-- ============================================================

CREATE TABLE consumes(
    ingredients_id  VARCHAR(50),
    entry_id        VARCHAR(50),
    quantity        INT,
    PRIMARY KEY(ingredients_id, entry_id),
    FOREIGN KEY(ingredients_id) REFERENCES ingredients(ingredients_id),
    FOREIGN KEY(entry_id)       REFERENCES ingredients_ate(entry_id)
);

CREATE TABLE recipe_ingredients(
    ingredients_id  VARCHAR(50),
    recipe_id       VARCHAR(50),
    quantity        INT,
    PRIMARY KEY(ingredients_id, recipe_id),
    FOREIGN KEY(ingredients_id) REFERENCES ingredients(ingredients_id),
    FOREIGN KEY(recipe_id)      REFERENCES recipe(recipe_id)
);

CREATE TABLE pairs(
    user_id     VARCHAR(50),
    device_id   VARCHAR(50),
    PRIMARY KEY(user_id, device_id),
    FOREIGN KEY(user_id)   REFERENCES user_(user_id),
    FOREIGN KEY(device_id) REFERENCES connected_device(device_id)
);

CREATE TABLE records(
    device_id   VARCHAR(50),
    measure_id  VARCHAR(50),
    PRIMARY KEY(device_id, measure_id),
    FOREIGN KEY(device_id)  REFERENCES connected_device(device_id),
    FOREIGN KEY(measure_id) REFERENCES biometric_measure(measure_id)
);

CREATE TABLE links(
    user_id     VARCHAR(50),
    source_id   VARCHAR(50),
    PRIMARY KEY(user_id, source_id),
    FOREIGN KEY(user_id)   REFERENCES user_(user_id),
    FOREIGN KEY(source_id) REFERENCES data_source(source_id)
);

CREATE TABLE gets(
    goal_id     VARCHAR(50),
    metric_id   VARCHAR(50),
    PRIMARY KEY(goal_id, metric_id),
    FOREIGN KEY(goal_id)   REFERENCES health_goal(goal_id),
    FOREIGN KEY(metric_id) REFERENCES user_metrics(metric_id)
);

CREATE TABLE has_feature(
    plan_id     VARCHAR(50),
    feature_id  VARCHAR(50),
    PRIMARY KEY(plan_id, feature_id),
    FOREIGN KEY(plan_id)    REFERENCES subscription_plan(plan_id),
    FOREIGN KEY(feature_id) REFERENCES feature(feature_id)
);



CREATE TABLE Parts_of(
    user_id         VARCHAR(50),
    organization_id VARCHAR(50),
    PRIMARY KEY(user_id, organization_id),
    FOREIGN KEY(user_id)         REFERENCES user_(user_id),
    FOREIGN KEY(organization_id) REFERENCES organization(organization_id)
);

-- ============================================================
-- INDEX DE PERFORMANCE
-- ============================================================

CREATE INDEX idx_sub_user_id    ON subscription(user_id);
CREATE INDEX idx_sub_status     ON subscription(status);
CREATE INDEX idx_sub_plan_id    ON subscription(plan_id);
CREATE INDEX idx_hist_sub_id    ON subscription_history(subscription_id);
CREATE INDEX idx_hist_occurred  ON subscription_history(occurred_at);
CREATE INDEX idx_pay_sub_id     ON payment_transaction(subscription_id);
CREATE INDEX idx_pay_status     ON payment_transaction(status);
CREATE INDEX idx_org_member     ON Parts_of(user_id, organization_id);
