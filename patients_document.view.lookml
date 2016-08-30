- view: patients_document
  sql_table_name: el8_app_1.patients_document
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: authoring_practice_id
    type: number
    sql: ${TABLE}.authoring_practice_id

  - dimension_group: chart_feed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.chart_feed_date

  - dimension: comments_closed_log_id
    type: number
    sql: ${TABLE}.comments_closed_log_id

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension_group: document
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.documentDate

  - dimension: document_sub_type
    type: number
    sql: ${TABLE}.document_sub_type

  - dimension: document_type
    type: number
    sql: ${TABLE}.document_type

  - dimension_group: last_modified
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: meaningful_use_info_id
    type: number
    sql: ${TABLE}.meaningful_use_info_id

  - dimension: patient_id
    type: number
    sql: ${TABLE}.patient_id

  - dimension: show_in_chart_feed
    type: yesno
    sql: ${TABLE}.show_in_chart_feed

  - dimension: sign_log_id
    type: number
    sql: ${TABLE}.signLog_id

  - measure: count
    type: count
    drill_fields: [id]

