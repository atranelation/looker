- view: messaging_threadmessage
  sql_table_name: el8_app_1.messaging_threadmessage
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: body
    type: string
    sql: ${TABLE}.body

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_date

  - dimension: sender_id
    type: number
    sql: ${TABLE}.sender_id

  - dimension: thread_id
    type: number
    sql: ${TABLE}.thread_id

  - dimension: to_document_id
    type: number
    sql: ${TABLE}.to_document_id

  - measure: count
    type: count
    drill_fields: [id]

