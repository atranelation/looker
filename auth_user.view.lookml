- view: auth_user
  label: Elation user login information
  sql_table_name: el8_app_1.auth_user
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: date_joined
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.date_joined

  - dimension: email
    hidden: true
    type: string
    sql: ${TABLE}.email

  - dimension: first_name
    hidden: true
    type: string
    sql: ${TABLE}.first_name

  - dimension: is_active
    hidden: true
    type: yesno
    sql: ${TABLE}.is_active

  - dimension: is_staff
    hidden: true
    type: yesno
    sql: ${TABLE}.is_staff

  - dimension: is_account_admin
    hidden: true
    type: yesno
    sql: ${TABLE}.is_superuser

  - dimension_group: last_login
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_login

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.last_name

  - dimension: password
    hidden: true
    type: string
    sql: ${TABLE}.password

  - dimension: username
    hidden: true
    type: string
    sql: ${TABLE}.username

  - measure: count
    hidden: true
    type: count
    drill_fields: [id, last_name, first_name, username, last_login]

