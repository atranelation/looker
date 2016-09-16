- view: auditlogging_actionlog
  sql_table_name: el8_app_1.auditlogging_actionlog
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: action_type
    type: string
    sql: ${TABLE}.actionType

  - dimension: behalf_user_id
    type: number
    sql: ${TABLE}.behalfUser_id

  - dimension: page_session
    type: string
    sql: ${TABLE}.page_session

  - dimension: patient_id
    type: number
    sql: ${TABLE}.patient_id

  - dimension: record_class
    type: string
    sql: ${TABLE}.recordClass

  - dimension_group: record
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.recordDate

  - dimension: record_id
    type: number
    sql: ${TABLE}.recordId

  - dimension: rel_record_class
    type: string
    sql: ${TABLE}.relRecordClass

  - dimension: rel_record_id
    type: number
    sql: ${TABLE}.relRecordId

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id

  - measure: count
    type: count
    drill_fields: [id]

