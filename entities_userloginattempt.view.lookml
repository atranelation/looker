- view: entities_userloginattempt
  sql_table_name: el8_app_1.entities_userloginattempt
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: email_attempted
    type: string
    sql: ${TABLE}.email_attempted

  - dimension: ip_address
    type: string
    sql: ${TABLE}.ip_address

  - dimension: login_type
    type: string
    sql: ${TABLE}.login_type

  - dimension: success
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
    sql: ${entities_practice.name}

  - measure: count
    type: count
    drill_fields: [id]

