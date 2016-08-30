- view: auth_user
  sql_table_name: el8_app_1.auth_user
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: date_joined
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_joined

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    type: string
    sql: ${TABLE}.first_name

  - dimension: is_active
    type: yesno
    sql: ${TABLE}.is_active

  - dimension: is_staff
    type: yesno
    sql: ${TABLE}.is_staff

  - dimension: is_superuser
    type: yesno
    sql: ${TABLE}.is_superuser

  - dimension_group: last_login
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_login

  - dimension: last_name
    type: string
    sql: ${TABLE}.last_name

  - dimension: password
    type: string
    sql: ${TABLE}.password

  - dimension: username
    type: string
    sql: ${TABLE}.username

  - measure: count
    type: count
    drill_fields: [id, last_name, first_name, username]

