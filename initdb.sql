CREATE TABLE health_goal(
   goal_id VARCHAR(50),
   label VARCHAR(50),
   description VARCHAR(50),
   PRIMARY KEY(goal_id)
);

CREATE TABLE Subscription_plan(
   plan_id VARCHAR(50),
   name VARCHAR(50),
   monthly_price INT,
   durations_month DATE,
   features_json VARCHAR(50),
   is_active LOGICAL,
   PRIMARY KEY(plan_id)
);

CREATE TABLE food(
   food_id VARCHAR(50),
   name VARCHAR(50),
   brand VARCHAR(50),
   calories_100g DECIMAL(15,2),
   fat_100g DECIMAL(15,2),
   nutriscore INT,
   category_ref VARCHAR(50),
   fiber_g DECIMAL(15,2),
   sugar_g DECIMAL(15,2),
   sodium_mg DECIMAL(15,2),
   cholesterol_mg DECIMAL(15,2),
   protein_100g DECIMAL(15,2),
   carbs_100g DECIMAL(15,2),
   PRIMARY KEY(food_id)
);

CREATE TABLE activity_type(
   activity_id VARCHAR(50),
   name VARCHAR(50),
   met_value INT,
   icon_url VARCHAR(50),
   PRIMARY KEY(activity_id)
);

CREATE TABLE excercise(
   excercie_id VARCHAR(50),
   name VARCHAR(50),
   body_part_target VARCHAR(50),
   video_url VARCHAR(50),
   description VARCHAR(50),
   difficulty_level INT,
   equipment_required VARCHAR(50),
   category VARCHAR(50),
   PRIMARY KEY(excercie_id)
);

CREATE TABLE data_source(
   source_id VARCHAR(50),
   source_name VARCHAR(50),
   source_type VARCHAR(50),
   format VARCHAR(50),
   source_url VARCHAR(50),
   expected_records VARCHAR(50),
   last_updates DATETIME,
   is_active LOGICAL,
   PRIMARY KEY(source_id)
);

CREATE TABLE etl_execution(
   execution_id VARCHAR(50),
   started_at DATETIME,
   ended_at DATETIME,
   status LOGICAL,
   records_extracted LOGICAL,
   records_loaded LOGICAL,
   records_rejected LOGICAL,
   error_message VARCHAR(50),
   triggered_by VARCHAR(50),
   source_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(execution_id),
   FOREIGN KEY(source_id) REFERENCES data_source(source_id)
);

CREATE TABLE data_quality_check_(
   check_id VARCHAR(50),
   target_table VARCHAR(50),
   check_type VARCHAR(50),
   check_rule VARCHAR(50),
   records_checked VARCHAR(50),
   records_failed VARCHAR(50),
   checked_at DATETIME,
   status LOGICAL,
   execution_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(check_id),
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

CREATE TABLE data_anomaly(
   anomaly_id VARCHAR(50),
   source_table VARCHAR(50),
   anomaly_table VARCHAR(50),
   field_name VARCHAR(50),
   record_identifier VARCHAR(50),
   original_value VARCHAR(50),
   detected_at DATETIME,
   seerity VARCHAR(50),
   is_resolved LOGICAL,
   resolution_action VARCHAR(50),
   check_id VARCHAR(50),
   execution_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(anomaly_id),
   FOREIGN KEY(check_id) REFERENCES data_quality_check_(check_id),
   FOREIGN KEY(execution_id) REFERENCES etl_execution(execution_id)
);

CREATE TABLE user_profile(
   profile_id VARCHAR(50),
   height_cm INT,
   current_weight_kg DECIMAL(3,2),
   activity_level_ref VARCHAR(50),
   allergies_json VARCHAR(50),
   preferences_json VARCHAR(50),
   updated_at DATETIME,
   goal_id VARCHAR(50),
   PRIMARY KEY(profile_id),
   FOREIGN KEY(goal_id) REFERENCES health_goal(goal_id)
);

CREATE TABLE user_(
   user_id VARCHAR(50),
   email VARCHAR(50),
   password_bash VARCHAR(20),
   first_name VARCHAR(50),
   last_name VARCHAR(50),
   birth_date DATE,
   gender_code INT,
   created_at DATE,
   is_active LOGICAL,
   role_code INT,
   profile_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(user_id),
   UNIQUE(profile_id),
   FOREIGN KEY(profile_id) REFERENCES user_profile(profile_id)
);

CREATE TABLE subsrciption(
   subscription_id VARCHAR(50),
   start_date DATE,
   end_date DATE,
   status LOGICAL,
   auto_renew LOGICAL,
   plan_id VARCHAR(50) NOT NULL,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(subscription_id),
   FOREIGN KEY(plan_id) REFERENCES Subscription_plan(plan_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE invoice(
   invoice_id VARCHAR(50),
   issued_at DATETIME,
   total_amount CURRENCY,
   status LOGICAL,
   pdf_url VARCHAR(50),
   subscription_id VARCHAR(50),
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(invoice_id),
   FOREIGN KEY(subscription_id) REFERENCES subsrciption(subscription_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE payment_transaction(
   transaction_id VARCHAR(50),
   processed_at DATETIME,
   amount CURRENCY,
   payment_method INT,
   transaction_ref_ext VARCHAR(50),
   status LOGICAL,
   invoice_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(transaction_id),
   FOREIGN KEY(invoice_id) REFERENCES invoice(invoice_id)
);

CREATE TABLE recipe(
   recipe_id VARCHAR(50),
   title VARCHAR(50),
   instructions VARCHAR(50),
   prep_time_min COUNTER,
   difficulty INT,
   created_by_user_id LOGICAL,
   user_id VARCHAR(50),
   PRIMARY KEY(recipe_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE recipe_ingredient(
   link_id VARCHAR(50),
   quantity_grams INT,
   recipe_id VARCHAR(50) NOT NULL,
   food_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(link_id),
   FOREIGN KEY(recipe_id) REFERENCES recipe(recipe_id),
   FOREIGN KEY(food_id) REFERENCES food(food_id)
);

CREATE TABLE food_diary_entry(
   entry_id VARCHAR(50),
   consumed_at DATE,
   quantity_grams INT,
   meal_type LOGICAL,
   calories_consumed INT,
   food_id VARCHAR(50) NOT NULL,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(entry_id),
   FOREIGN KEY(food_id) REFERENCES food(food_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE workout_session(
   session_id VARCHAR(50),
   start_time DATE,
   duration_time COUNTER,
   calories_burned INT,
   notes VARCHAR(50),
   distance_km DECIMAL(15,2),
   activity_id VARCHAR(50) NOT NULL,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(session_id),
   FOREIGN KEY(activity_id) REFERENCES activity_type(activity_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE session_detail(
   detail_id VARCHAR(50),
   sets INT,
   reps INT,
   weight_kg INT,
   excercie_id VARCHAR(50) NOT NULL,
   session_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(detail_id),
   FOREIGN KEY(excercie_id) REFERENCES excercise(excercie_id),
   FOREIGN KEY(session_id) REFERENCES workout_session(session_id)
);

CREATE TABLE connected_device(
   device_id VARCHAR(50),
   device_name VARCHAR(50),
   device_type VARCHAR(50),
   last_synce DATE,
   is_active LOGICAL,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(device_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE biometric_measure(
   measure_id VARCHAR(50),
   type VARCHAR(50),
   value_ INT,
   measured_at DATETIME,
   device_id VARCHAR(50),
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(measure_id),
   FOREIGN KEY(device_id) REFERENCES connected_device(device_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE ai_recommendation(
   recommendation_id VARCHAR(50),
   generated_at DATETIME,
   category VARCHAR(50),
   title VARCHAR(50),
   content_text VARCHAR(200),
   confidence_score DECIMAL(15,2),
   is_viewed LOGICAL,
   feedback_rating DECIMAL(15,2),
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(recommendation_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE progress_tracker(
   progress_id VARCHAR(50),
   weight_kg DECIMAL(15,2),
   body_fat_pourcentage DECIMAL(15,2),
   weekly_calories_avg DECIMAL(15,2),
   created_at DATETIME,
   goal_achievement_json VARCHAR(50),
   wekkly_workouts_count INT,
   tracking_date DATE,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(progress_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE user_metrics(
   metric_id VARCHAR(50),
   recorded_date DATE,
   weight_kg DECIMAL(15,2),
   body_fat_pourcentage INT,
   steps INT,
   calories_burned DECIMAL(15,2),
   heart_rate_avg INT,
   heart_rate_max INT,
   sleep_hours INT,
   created_at DATETIME,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(metric_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);

CREATE TABLE diet_recommendation(
   recommendation_id VARCHAR(50),
   meal_type LOGICAL,
   recommended_foods VARCHAR(50),
   total_calories INT,
   protein_g INT,
   carbs_g INT,
   fat_g INT,
   diet_type LOGICAL,
   generated_at DATETIME,
   is_followed LOGICAL,
   user_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(recommendation_id),
   FOREIGN KEY(user_id) REFERENCES user_(user_id)
);
