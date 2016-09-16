- view: patients_patient
  sql_table_name: el8_app_1.patients_patient
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension: chart_number
    hidden: true
    type: string
    sql: ${TABLE}.chartNumber

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    hidden: true
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: demo
    hidden: true
    type: yesno
    sql: ${TABLE}.demo

  - dimension_group: dob
    type: time
    hidden: true
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: ethnicity
    type: number
    sql: ${TABLE}.ethnicity

  - dimension: first_name
    hidden: true
    type: string
    sql: ${TABLE}.firstName

  - dimension_group: last_modified
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.lastName

  - dimension: marital_status
    hidden: true
    type: string
    sql: ${TABLE}.maritalStatus

  - dimension: master_id
    type: number
    sql: ${TABLE}.master_id

  - dimension: middle_name
    hidden: true
    type: string
    sql: ${TABLE}.middleName

  - dimension: notes
    hidden: true
    type: string
    sql: ${TABLE}.notes

  - dimension: occupation
    hidden: true
    type: string
    sql: ${TABLE}.occupation

  - dimension: preferred_contact
    hidden: true
    type: string
    sql: ${TABLE}.preferredContact

  - dimension: preferred_language_id
    hidden: true
    type: number
    sql: ${TABLE}.preferredLanguage_id

  - dimension: preferred_notification
    hidden: true
    type: string
    sql: ${TABLE}.preferred_notification

  - dimension: prefix
    hidden: true
    type: string
    sql: ${TABLE}.prefix

  - dimension: primary_address_id
    hidden: true
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
  
  - dimension: age
    type: number
    sql: TRUNCATE(DATEDIFF(CURDATE(), dob)/365.25, 0)
    value_format: '0'

  - dimension: ssn
    hidden: true
    type: string
    sql: ${TABLE}.ssn

  - dimension: suffix
    hidden: true
    type: string
    sql: ${TABLE}.suffix

  - dimension: verified
    hidden: true
    type: yesno
    sql: ${TABLE}.verified

  - measure: count
    type: count
    drill_fields: [id, sex, city]

