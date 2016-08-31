- view: entities_userprofile
  sql_table_name: el8_app_1.entities_userprofile
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: emergency_on
    type: yesno
    sql: ${TABLE}.emergency_on

  - dimension: has_chart_access
    type: yesno
    sql: ${TABLE}.has_chart_access

  - dimension: is_elation_staff
    type: yesno
    sql: ${TABLE}.is_elation_staff

  - dimension: is_emergency
    type: yesno
    sql: ${TABLE}.is_emergency

  - dimension: is_practice_admin
    type: yesno
    sql: ${TABLE}.is_practice_admin

  - dimension: opt_email_daily
    type: yesno
    sql: ${TABLE}.optEmailDaily

  - dimension: opt_email_weekly
    type: yesno
    sql: ${TABLE}.optEmailWeekly

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - dimension_group: time_credentialed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_credentialed

  - dimension_group: time_email_verified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_email_verified

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id

  - dimension_group: verify
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.verifyDate
    
  - dimension: practice_name 
    sql: ${entities_practice.name}

  - measure: count
    type: count
    drill_fields: [id]

