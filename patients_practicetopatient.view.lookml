- view: patients_practicetopatient
  sql_table_name: el8_app_1.patients_practicetopatient
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: granted_meds
    type: yesno
    sql: ${TABLE}.granted_meds

  - dimension: granted_problems
    type: yesno
    sql: ${TABLE}.granted_problems

  - dimension: granted_refpanel
    type: number
    sql: ${TABLE}.granted_refpanel

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: patient_id
    type: number
    sql: ${TABLE}.patient_id

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - dimension: primary_physician_user_id
    type: number
    sql: ${TABLE}.primaryPhysicianUser_id

  - dimension: role
    type: number
    sql: ${TABLE}.role

  - measure: count
    type: count
    drill_fields: [id]

