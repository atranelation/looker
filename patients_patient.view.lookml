- view: patients_patient
  sql_table_name: el8_app_1.patients_patient
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: chart_number
    type: string
    sql: ${TABLE}.chartNumber

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: demo
    type: yesno
    sql: ${TABLE}.demo

  - dimension_group: dob
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: ethnicity
    type: number
    sql: ${TABLE}.ethnicity

  - dimension: first_name
    type: string
    sql: ${TABLE}.firstName

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: last_name
    type: string
    sql: ${TABLE}.lastName

  - dimension: marital_status
    type: string
    sql: ${TABLE}.maritalStatus

  - dimension: master_id
    type: number
    sql: ${TABLE}.master_id

  - dimension: middle_name
    type: string
    sql: ${TABLE}.middleName

  - dimension: notes
    type: string
    sql: ${TABLE}.notes

  - dimension: occupation
    type: string
    sql: ${TABLE}.occupation

  - dimension: preferred_contact
    type: string
    sql: ${TABLE}.preferredContact

  - dimension: preferred_language_id
    type: number
    sql: ${TABLE}.preferredLanguage_id

  - dimension: preferred_notification
    type: string
    sql: ${TABLE}.preferred_notification

  - dimension: prefix
    type: string
    sql: ${TABLE}.prefix

  - dimension: primary_address_id
    type: number
    sql: ${TABLE}.primary_address_id

  - dimension: race
    type: number
    sql: ${TABLE}.race

  - dimension: secondary_race
    type: number
    sql: ${TABLE}.secondary_race

  - dimension: sex
    type: string
    sql: ${TABLE}.sex

  - dimension: ssn
    type: string
    sql: ${TABLE}.ssn

  - dimension: suffix
    type: string
    sql: ${TABLE}.suffix

  - dimension: verified
    type: yesno
    sql: ${TABLE}.verified

  - measure: count
    type: count
    drill_fields: [id, first_name, last_name, middle_name]

