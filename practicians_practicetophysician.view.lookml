- view: practicians_practicetophysician
  sql_table_name: el8_app_1.practicians_practicetophysician
  fields:

  - dimension: id
    hidden: true
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: account_type
    hidden: true
    type: string
    sql: ${TABLE}.account_type

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: physician_id
    hidden: true
    type: number
    sql: ${TABLE}.physician_id

  - dimension: practice_id
    hidden: true
    type: number
    sql: ${TABLE}.practice_id

  - measure: count
    hidden: true
    type: count
    drill_fields: [id]

