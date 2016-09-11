- view: entities_userloginattempt
  sql_table_name: el8_app_1.entities_userloginattempt
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension: email_attempted
    hidden: true
    type: string
    sql: ${TABLE}.email_attempted

  - dimension: ip_address
    hidden: true
    type: string
    sql: ${TABLE}.ip_address

  - dimension: login_type
    hidden: true
    type: string
    sql: ${TABLE}.login_type

  - dimension: success
    hidden: true
    type: yesno
    sql: ${TABLE}.success

  - dimension_group: time_attempted
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_attempted

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id
  
  - dimension: practice_name 
    sql: ${entities_userprofile.practice_name}
    
  - dimension: physician_name
    sql: CONCAT(${practicians_physician.first_name}, ${practicians_physician.last_name})  
    
  - dimension: user_type
    sql: ${entities_userprofile.user_type}
    
  - dimension: physician_specialty
    sql: ${shareable_medicalspecialty.name}
  
  - measure: count
    type: count
    drill_fields: [practice_name]

  - measure: unique_user_count
    type: count_distinct
    sql: ${TABLE}.user_id
    drill_fields: [user_type, physician_name, physician_specialty, practice_name]
