- view: messaging_threadmessage
  label: messages_sent
  sql_table_name: el8_app_1.messaging_threadmessage
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension: body
    hidden: true
    type: string
    sql: ${TABLE}.body

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_date

  - dimension: sender_user_id
    type: number
    sql: ${TABLE}.sender_id

  - dimension: thread_id
    type: number
    sql: ${TABLE}.thread_id

  - dimension: to_document_id
    hidden: true
    type: number
    sql: ${TABLE}.to_document_id

  - measure: count
    type: count
    drill_fields: [id, sender_user_id]

