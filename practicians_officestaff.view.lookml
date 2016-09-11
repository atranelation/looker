- view: practicians_officestaff
  sql_table_name: el8_app_1.practicians_officestaff
  fields:

  - dimension: id
    hidden: true
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension_group: dob
    hidden: true
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: email
    hidden: true
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    hidden: true
    type: string
    sql: ${TABLE}.firstName

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.lastName

  - dimension: middle_name
    hidden: true
    type: string
    sql: ${TABLE}.middleName

  - dimension: phone
    hidden: true
    type: string
    sql: ${TABLE}.phone

  - dimension: prefix
    hidden: true
    type: string
    sql: ${TABLE}.prefix

  - dimension: sex
    hidden: true
    type: string
    sql: ${TABLE}.sex

  - dimension: suffix
    hidden: true
    type: string
    sql: ${TABLE}.suffix

  - measure: count
    hidden: true
    type: count
    drill_fields: [id, middle_name, last_name, first_name]

