- view: meds_medorderfulfillment
  hidden: true
  sql_table_name: el8_app_1.meds_medorderfulfillment
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: detail
    type: string
    sql: ${TABLE}.detail

  - dimension: dismiss_log_id
    type: number
    sql: ${TABLE}.dismissLog_id

  - dimension_group: insert
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.insert_time

  - dimension: med_order_id
    type: number
    sql: ${TABLE}.med_order_id

  - dimension: pharmacy_ncpdpid
    type: string
    sql: ${TABLE}.pharmacy_ncpdpid

  - dimension: service_location_id
    type: number
    sql: ${TABLE}.service_location_id

  - dimension: ss_code
    type: string
    sql: ${TABLE}.ss_code

  - dimension: ss_desc_code
    type: string
    sql: ${TABLE}.ss_desc_code

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension_group: time_completed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_completed

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - measure: count
    type: count
    drill_fields: [id]

