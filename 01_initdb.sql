-- SCRIPT PostreSQL pour la DB

-- Pour le hachage ---------------------------------------
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ENUMS ------------------------------------------------

CREATE TYPE nutriscore_enum AS ENUM (
    'A', 'B', 'C', 'D', 'E'
);

CREATE TYPE ingredient_category_enum AS ENUM (
    'VEGETABLE', 'FRUIT', 'MEAT', 'DAIRY', 'GRAIN', 'BEVERAGE', 'SNACK', 'OTHER'
);

CREATE TYPE exercise_difficulty_enum AS ENUM (
    'BEGINNER', 'INTERMEDIATE', 'ADVANCED'
);

CREATE TYPE exercise_category_enum AS ENUM (
    'CARDIO', 'STRENGTH', 'FLEXIBILITY', 'BALANCE', 'OTHER'
);

CREATE TYPE allergies_enum AS ENUM (
    'NONE', 'MILK', 'GLUTEN', 'SEAFOOD', 'SOY', 'EGGS', 'NUTS', 'OTHER'
);

CREATE TYPE diet_type_enum AS ENUM (
    'NONE', 'VEGETARIAN', 'VEGAN', 'PESCATARIAN', 'KETO', 'PALEO', 'OTHER'
);

CREATE TYPE role_type_enum AS ENUM (
    'FREEMIUM', 'PREMIUM', 'PREMIUM_PLUS', 'B2B', 'ADMIN'
);

CREATE TYPE body_part_enum AS ENUM (
    'ARMS', 'LEGS', 'BACK', 'CHEST', 'SHOULDERS', 'CORE', 'FULL_BODY'
);

CREATE TYPE pipeline_status_enum AS ENUM (
    'PENDING', 'FAILED', 'TRANSFORMED', 'REJECTED', 'LOADED'
);

-- TABLES ------------------------------------------------

CREATE TABLE health_goal(
   goal_id VARCHAR(255) DEFAULT gen_random_uuid(),
   label VARCHAR(50),
   description TEXT,
   PRIMARY KEY(goal_id)
);

CREATE TABLE ingredient(
   ingredient_id VARCHAR(255) DEFAULT gen_random_uuid(),
   name VARCHAR(255),
   usda_name VARCHAR(255),
   category ingredient_category_enum,
   nutriscore nutriscore_enum,
   -- Valeurs nutritionnelles pour 100g
   calories_g DECIMAL(6,2),
   fat_g DECIMAL(5,2),
   fiber_g DECIMAL(5,2),
   sugar_g DECIMAL(5,2),
   sodium_mg DECIMAL(5,2),
   cholesterol_mg DECIMAL(5,2),
   protein_g DECIMAL(5,2),
   carbs_g DECIMAL(5,2),
   PRIMARY KEY(ingredient_id)
);

CREATE TABLE recipe(
   recipe_id VARCHAR(255) DEFAULT gen_random_uuid(),
   title VARCHAR(255),
   instructions TEXT,
   PRIMARY KEY(recipe_id)
);

CREATE TABLE exercise(
   exercise_id VARCHAR(255) DEFAULT gen_random_uuid(),
   name VARCHAR(255),
   description TEXT,
   body_part_target body_part_enum,
   video_url TEXT,
   difficulty_level exercise_difficulty_enum,
   equipment_required TEXT,
   category exercise_category_enum,
   PRIMARY KEY(exercise_id)
);


CREATE TABLE etl_execution(
   execution_id VARCHAR(255) DEFAULT gen_random_uuid(),
   name VARCHAR(255),
   started_at TIMESTAMP,
   ended_at TIMESTAMP,
   status pipeline_status_enum,
   records_extracted INT,
   records_loaded INT,
   records_rejected INT,
   error_message TEXT,
   PRIMARY KEY(execution_id)
);

CREATE TABLE data_quality_check_(
   check_id VARCHAR(255) DEFAULT gen_random_uuid(),
   target_table VARCHAR(50),
   check_type VARCHAR(50),
   check_rule VARCHAR(50),
   records_checked INT,
   records_failed INT,
   checked_at TIMESTAMP,
   status BOOLEAN,
   execution_id VARCHAR(255) NOT NULL,
   PRIMARY KEY(check_id),
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id) ON DELETE CASCADE
);

CREATE TABLE data_anomaly(
   anomaly_id VARCHAR(255) DEFAULT gen_random_uuid(),
   source_table VARCHAR(50),
   anomaly_table VARCHAR(50),
   field_name VARCHAR(50),
   record_identifier VARCHAR(50),
   original_value TEXT,
   detected_at TIMESTAMP,
   severity VARCHAR(50),
   is_resolved BOOLEAN,
   resolution_action VARCHAR(50),
   check_id VARCHAR(50),
   execution_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(anomaly_id),
   FOREIGN KEY(check_id) REFERENCES data_quality_check_(check_id) ON DELETE CASCADE,
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id) ON DELETE CASCADE
);

CREATE TABLE role(
   role_id VARCHAR(255) DEFAULT gen_random_uuid(),
   role_type role_type_enum NOT NULL UNIQUE,
   is_system BOOLEAN,
   PRIMARY KEY(role_id)
);

CREATE TABLE organization(
   organization_id VARCHAR(255) DEFAULT gen_random_uuid(),
   name VARCHAR(255),
   PRIMARY KEY(organization_id)
);

CREATE TABLE user_(
   user_id VARCHAR(255) DEFAULT gen_random_uuid(),
   email VARCHAR(320) UNIQUE NOT NULL,
   password_hash VARCHAR(255) NOT NULL,
   first_name VARCHAR(255),
   last_name VARCHAR(255),
   birth_date DATE,
   gender_code INT,
   height_cm DECIMAL(5,2),
   current_weight_kg DECIMAL(5,2),
   allergies allergies_enum DEFAULT 'NONE',
   diet_type diet_type_enum DEFAULT 'NONE',
   is_active BOOLEAN DEFAULT true,
   role_id VARCHAR(255) NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY(user_id),
   FOREIGN KEY(role_id) REFERENCES role(role_id)
);

CREATE TABLE user_metrics(
   metric_id VARCHAR(255) DEFAULT gen_random_uuid(),
   user_id VARCHAR(255) NOT NULL,
   recorded_date TIMESTAMP,
   weight_kg DECIMAL(10,2),
   body_fat_pourcentage DECIMAL(6,2),
   steps INT,
   calories_burned DECIMAL(10,2),
   heart_rate_avg INT,
   heart_rate_max INT,
   sleep_hours INT,
   PRIMARY KEY(metric_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id) ON DELETE CASCADE
);

CREATE TABLE login_history(
   last_login_id VARCHAR(255) PRIMARY KEY DEFAULT gen_random_uuid()::VARCHAR,
   user_id VARCHAR(255) NOT NULL,
   last_login TIMESTAMP NOT NULL,
   FOREIGN KEY(user_id) REFERENCES user_(user_id) ON DELETE CASCADE
);

CREATE TABLE meal(
   meal_id VARCHAR(255) DEFAULT gen_random_uuid(),
   consumed_at TIMESTAMP,
   quantity_grams INT,
   calories_consumed INT,
   user_id VARCHAR(255) NOT NULL,
   PRIMARY KEY(meal_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id) ON DELETE CASCADE
);

CREATE TABLE workout_session(
   session_id VARCHAR(255) DEFAULT gen_random_uuid(),
   start_at TIMESTAMP,
   end_at TIMESTAMP,
   calories_burned SMALLINT,
   notes TEXT,
   user_id VARCHAR(255) NOT NULL,
   PRIMARY KEY(session_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id) ON DELETE CASCADE
);

CREATE TABLE user_health_goal(
   user_id VARCHAR(255),
   goal_id VARCHAR(255),
   PRIMARY KEY(user_id, goal_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id),
   FOREIGN KEY(goal_id) REFERENCES health_goal(goal_id)
);

CREATE TABLE meal_ingredient(
   ingredient_id VARCHAR(255),
   meal_id VARCHAR(255),
   quantity INT,
   PRIMARY KEY(ingredient_id, meal_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id),
   FOREIGN KEY(meal_id) REFERENCES meal(meal_id)
);

CREATE TABLE recipe_ingredients(
   ingredient_id VARCHAR(255),
   recipe_id VARCHAR(255),
   quantity INT,
   PRIMARY KEY(ingredient_id, recipe_id),
   FOREIGN KEY(ingredient_id) REFERENCES ingredient(ingredient_id),
   FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
);

CREATE TABLE user_organization(
   user_id VARCHAR(255),
   organization_id VARCHAR(255),
   PRIMARY KEY(user_id, organization_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id),
   FOREIGN KEY(organization_id) REFERENCES organization(organization_id)
);

CREATE TABLE workout_session_exercise(
   session_id VARCHAR(255),
   exercise_id VARCHAR(255),
   sets INT,
   PRIMARY KEY(session_id, exercise_id),
   FOREIGN KEY(session_id) REFERENCES workout_session(session_id),
   FOREIGN KEY(exercise_id) REFERENCES exercise(exercise_id)
);