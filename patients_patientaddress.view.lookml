- view: patients_patientaddress
  sql_table_name: el8_app_1.patients_patientaddress
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: address
    type: string
    sql: ${TABLE}.address

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: patient_id
    type: number
    sql: ${TABLE}.patient_id

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: suite
    type: string
    sql: ${TABLE}.suite

  - dimension: zip
    type: string
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id]

