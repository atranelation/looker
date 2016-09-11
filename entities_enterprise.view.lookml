- view: entities_enterprise
  sql_table_name: el8_app_1.entities_enterprise
  fields:

  - dimension: id
    hidden: true
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: default_timezone
    hidden: true
    type: string
    sql: ${TABLE}.default_timezone

  - dimension: feedback_email
    hidden: true
    type: string
    sql: ${TABLE}.feedback_email

  - dimension: name
    hidden: true
    type: string
    sql: ${TABLE}.name

  - measure: count
    hidden: true
    type: count
    drill_fields: [id, name]

