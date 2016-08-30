- view: practicians_officestaff
  sql_table_name: el8_app_1.practicians_officestaff
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension_group: dob
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    type: string
    sql: ${TABLE}.firstName

  - dimension: last_name
    type: string
    sql: ${TABLE}.lastName

  - dimension: middle_name
    type: string
    sql: ${TABLE}.middleName

  - dimension: phone
    type: string
    sql: ${TABLE}.phone

  - dimension: prefix
    type: string
    sql: ${TABLE}.prefix

  - dimension: sex
    type: string
    sql: ${TABLE}.sex

  - dimension: suffix
    type: string
    sql: ${TABLE}.suffix

  - measure: count
    type: count
    drill_fields: [id, middle_name, last_name, first_name]

