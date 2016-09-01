- view: shareable_medicalspecialty
  sql_table_name: el8_app_1.shareable_medicalspecialty
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: abbreviation
    type: string
    sql: ${TABLE}.abbreviation

  - dimension: category_id
    type: number
    sql: ${TABLE}.category_id

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: name
    type: string
    sql: ${TABLE}.name

  - dimension: practice_created_id
    type: number
    sql: ${TABLE}.practice_created_id

  - measure: count
    type: count
    drill_fields: [id, name]

