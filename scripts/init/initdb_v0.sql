CREATE TABLE health_goal(
   goal_id VARCHAR(50) ,
   label VARCHAR(50) ,
   description VARCHAR(50) ,
   PRIMARY KEY(goal_id)
);

CREATE TABLE fonctionnality(
   fonctionnality_id VARCHAR(50) ,
   name VARCHAR(50) ,
   monthly_price INTEGER,
   durations_month DATE,
   is_active BOOLEAN,
   PRIMARY KEY(fonctionnality_id)
);

CREATE TABLE subsrciption(
   subscription_id VARCHAR(50) ,
   start_date DATE,
   end_date DATE,
   status BOOLEAN,
   auto_renew BOOLEAN,
   fonctionnality_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(subscription_id),
   FOREIGN KEY(fonctionnality_id) REFERENCES fonctionnality(fonctionnality_id)
);

CREATE TABLE payment_transaction(
   transaction_id VARCHAR(50) ,
   processed_at TIMESTAMP,
   amount MONEY,
   payment_method INTEGER,
   transaction_ref_ext VARCHAR(50) ,
   status BOOLEAN,
   subscription_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(transaction_id),
   FOREIGN KEY(subscription_id) REFERENCES subsrciption(subscription_id)
);

CREATE TABLE ingredients(
   ingredients_id VARCHAR(50) ,
   name VARCHAR(50) ,
   brand VARCHAR(50) ,
   calories_100g NUMERIC(15,2)  ,
   fat_100g NUMERIC(15,2)  ,
   nutriscore INTEGER,
   category_ref VARCHAR(50) ,
   fiber_g NUMERIC(15,2)  ,
   sugar_g NUMERIC(15,2)  ,
   sodium_mg NUMERIC(15,2)  ,
   cholesterol_mg NUMERIC(15,2)  ,
   protein_100g NUMERIC(15,2)  ,
   carbs_100g NUMERIC(15,2)  ,
   PRIMARY KEY(ingredients_id)
);

CREATE TABLE recipe(
   recipe_id VARCHAR(50) ,
   title VARCHAR(50) ,
   instructions VARCHAR(50) ,
   prep_time_min SERIAL,
   difficulty INTEGER,
   created_by_user_id BOOLEAN,
   PRIMARY KEY(recipe_id)
);

CREATE TABLE activity_type(
   activity_id VARCHAR(50) ,
   name VARCHAR(50) ,
   met_value INTEGER,
   icon_url VARCHAR(50) ,
   PRIMARY KEY(activity_id)
);

CREATE TABLE excercise(
   excercie_id VARCHAR(50) ,
   name VARCHAR(50) ,
   body_part_target VARCHAR(50) ,
   video_url VARCHAR(50) ,
   description VARCHAR(50) ,
   difficulty_level INTEGER,
   equipment_required VARCHAR(50) ,
   category VARCHAR(50) ,
   PRIMARY KEY(excercie_id)
);

CREATE TABLE connected_device(
   device_id VARCHAR(50) ,
   device_name VARCHAR(50) ,
   device_type VARCHAR(50) ,
   last_synce DATE,
   is_active BOOLEAN,
   PRIMARY KEY(device_id)
);

CREATE TABLE user_metrics(
   metric_id VARCHAR(50) ,
   recorded_date DATE,
   weight_kg NUMERIC(15,2)  ,
   body_fat_pourcentage INTEGER,
   steps INTEGER,
   calories_burned NUMERIC(15,2)  ,
   heart_rate_avg INTEGER,
   heart_rate_max INTEGER,
   sleep_hours INTEGER,
   PRIMARY KEY(metric_id)
);

CREATE TABLE data_source(
   source_id VARCHAR(50) ,
   source_name VARCHAR(50) ,
   source_type VARCHAR(50) ,
   format VARCHAR(50) ,
   source_url VARCHAR(50) ,
   expected_records VARCHAR(50) ,
   last_updates TIMESTAMP,
   is_active BOOLEAN,
   PRIMARY KEY(source_id)
);

CREATE TABLE etl_execution(
   execution_id VARCHAR(50) ,
   started_at TIMESTAMP,
   ended_at TIMESTAMP,
   status BOOLEAN,
   records_extracted BOOLEAN,
   records_loaded BOOLEAN,
   records_rejected BOOLEAN,
   error_message VARCHAR(50) ,
   triggered_by VARCHAR(50) ,
   source_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(execution_id),
   FOREIGN KEY(source_id) REFERENCES data_source(source_id)
);

CREATE TABLE data_quality_check_(
   check_id VARCHAR(50) ,
   target_table VARCHAR(50) ,
   check_type VARCHAR(50) ,
   check_rule VARCHAR(50) ,
   records_checked VARCHAR(50) ,
   records_failed VARCHAR(50) ,
   checked_at TIMESTAMP,
   status BOOLEAN,
   execution_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(check_id),
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

CREATE TABLE data_anomaly(
   anomaly_id VARCHAR(50) ,
   source_table VARCHAR(50) ,
   anomaly_table VARCHAR(50) ,
   field_name VARCHAR(50) ,
   record_identifier VARCHAR(50) ,
   original_value VARCHAR(50) ,
   detected_at TIMESTAMP,
   seerity VARCHAR(50) ,
   is_resolved BOOLEAN,
   resolution_action VARCHAR(50) ,
   check_id VARCHAR(50) ,
   execution_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(anomaly_id),
   FOREIGN KEY(check_id) REFERENCES data_quality_check_(check_id),
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

CREATE TABLE society(
   id_society VARCHAR(50) ,
   name VARCHAR(50) ,
   PRIMARY KEY(id_society)
);

CREATE TABLE history(
   history_id VARCHAR(50) ,
   PRIMARY KEY(history_id)
);

CREATE TABLE user_profile(
   profile_id VARCHAR(50) ,
   height_cm INTEGER,
   current_weight_kg NUMERIC(3,2)  ,
   activity_level_ref VARCHAR(50) ,
   updated_at TIMESTAMP,
   goal_id VARCHAR(50) ,
   PRIMARY KEY(profile_id),
   FOREIGN KEY(goal_id) REFERENCES health_goal(goal_id)
);

CREATE TABLE user_(
   user_id VARCHAR(50) ,
   email VARCHAR(50) ,
   password_bash VARCHAR(20) ,
   first_name VARCHAR(50) ,
   last_name VARCHAR(50) ,
   birth_date DATE,
   gender_code INTEGER,
   created_at DATE,
   is_active BOOLEAN,
   role_code INTEGER,
   history_id VARCHAR(50)  NOT NULL,
   profile_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(user_id),
   UNIQUE(history_id),
   UNIQUE(profile_id),
   FOREIGN KEY(history_id) REFERENCES history(history_id),
   FOREIGN KEY(profile_id) REFERENCES user_profile(profile_id)
);

CREATE TABLE ingredients_ate(
   entry_id VARCHAR(50) ,
   consumed_at DATE,
   quantity_grams INTEGER,
   meal_type BOOLEAN,
   calories_consumed INTEGER,
   user_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(entry_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE workout_session(
   session_id VARCHAR(50) ,
   start_time DATE,
   duration_time SERIAL,
   calories_burned INTEGER,
   notes VARCHAR(50) ,
   distance_km NUMERIC(15,2)  ,
   activity_id VARCHAR(50)  NOT NULL,
   user_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(session_id),
   FOREIGN KEY(activity_id) REFERENCES activity_type(activity_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE session_detail(
   detail_id VARCHAR(50) ,
   sets INTEGER,
   reps INTEGER,
   weight_kg INTEGER,
   excercie_id VARCHAR(50)  NOT NULL,
   session_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(detail_id),
   FOREIGN KEY(excercie_id) REFERENCES excercise(excercie_id),
   FOREIGN KEY(session_id) REFERENCES workout_session(session_id)
);

CREATE TABLE biometric_measure(
   measure_id VARCHAR(50) ,
   type VARCHAR(50) ,
   value_ INTEGER,
   measured_at TIMESTAMP,
   user_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(measure_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE ai_recommendation(
   recommendation_id VARCHAR(50) ,
   generated_at TIMESTAMP,
   category VARCHAR(50) ,
   title VARCHAR(50) ,
   content_text VARCHAR(200) ,
   confidence_score NUMERIC(15,2)  ,
   is_viewed BOOLEAN,
   feedback_rating NUMERIC(15,2)  ,
   user_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(recommendation_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE diet_recommendation(
   recommendation_id VARCHAR(50) ,
   meal_type BOOLEAN,
   recommended_foods VARCHAR(50) ,
   total_calories INTEGER,
   protein_g INTEGER,
   carbs_g INTEGER,
   fat_g INTEGER,
   diet_type BOOLEAN,
   generated_at TIMESTAMP,
   is_followed BOOLEAN,
   user_id VARCHAR(50)  NOT NULL,
   PRIMARY KEY(recommendation_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE consumes(
   ingredients_id VARCHAR(50) ,
   entry_id VARCHAR(50) ,
   quantity INTEGER,
   PRIMARY KEY(ingredients_id, entry_id),
   FOREIGN KEY(ingredients_id) REFERENCES ingredients(ingredients_id),
   FOREIGN KEY(entry_id) REFERENCES ingredients_ate(entry_id)
);

CREATE TABLE recipe_ingredients(
   ingredients_id VARCHAR(50) ,
   recipe_id VARCHAR(50) ,
   quantity INTEGER,
   PRIMARY KEY(ingredients_id, recipe_id),
   FOREIGN KEY(ingredients_id) REFERENCES ingredients(ingredients_id),
   FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id)
);

CREATE TABLE pairs(
   user_id VARCHAR(50) ,
   device_id VARCHAR(50) ,
   PRIMARY KEY(user_id, device_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id),
   FOREIGN KEY(device_id) REFERENCES connected_device(device_id)
);

CREATE TABLE records(
   device_id VARCHAR(50) ,
   measure_id VARCHAR(50) ,
   PRIMARY KEY(device_id, measure_id),
   FOREIGN KEY(device_id) REFERENCES connected_device(device_id),
   FOREIGN KEY(measure_id) REFERENCES biometric_measure(measure_id)
);

CREATE TABLE Parts_of(
   user_id VARCHAR(50) ,
   id_society VARCHAR(50) ,
   PRIMARY KEY(user_id, id_society),
   FOREIGN KEY(user_id) REFERENCES user_(user_id),
   FOREIGN KEY(id_society) REFERENCES society(id_society)
);

CREATE TABLE creates(
   subscription_id VARCHAR(50) ,
   id_society VARCHAR(50) ,
   PRIMARY KEY(subscription_id, id_society),
   FOREIGN KEY(subscription_id) REFERENCES subsrciption(subscription_id),
   FOREIGN KEY(id_society) REFERENCES society(id_society)
);

CREATE TABLE links(
   user_id VARCHAR(50) ,
   source_id VARCHAR(50) ,
   PRIMARY KEY(user_id, source_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id),
   FOREIGN KEY(source_id) REFERENCES data_source(source_id)
);

CREATE TABLE gets(
   goal_id VARCHAR(50) ,
   metric_id VARCHAR(50) ,
   PRIMARY KEY(goal_id, metric_id),
   FOREIGN KEY(goal_id) REFERENCES health_goal(goal_id),
   FOREIGN KEY(metric_id) REFERENCES user_metrics(metric_id)
);

CREATE TABLE regroups(
   subscription_id VARCHAR(50) ,
   history_id VARCHAR(50) ,
   PRIMARY KEY(subscription_id, history_id),
   FOREIGN KEY(subscription_id) REFERENCES subsrciption(subscription_id),
   FOREIGN KEY(history_id) REFERENCES history(history_id)
);
