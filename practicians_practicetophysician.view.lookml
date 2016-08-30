- view: practicians_practicetophysician
  sql_table_name: el8_app_1.practicians_practicetophysician
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: account_type
    type: string
    sql: ${TABLE}.account_type

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: physician_id
    type: number
    sql: ${TABLE}.physician_id

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - measure: count
    type: count
    drill_fields: [id]

