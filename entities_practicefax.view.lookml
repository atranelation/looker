- view: entities_practicefax
  sql_table_name: el8_app_1.entities_practicefax
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: fax
    type: string
    sql: ${TABLE}.fax

  - dimension: is_active
    type: yesno
    sql: ${TABLE}.is_active

  - dimension: name
    type: string
    sql: ${TABLE}.name

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - measure: count
    type: count
    drill_fields: [id, name]

