- view: filemgr_incomingfilegroup
  sql_table_name: el8_app_1.filemgr_incomingfilegroup
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: content_type
    type: string
    sql: ${TABLE}.content_type

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: fax_id
    type: number
    sql: ${TABLE}.fax_id

  - dimension: file_path
    type: string
    sql: ${TABLE}.file_path

  - dimension: file_size
    type: number
    sql: ${TABLE}.file_size

  - dimension: from_npi
    type: string
    sql: ${TABLE}.from_npi

  - dimension: from_number
    type: string
    sql: ${TABLE}.from_number

  - dimension: original_filename
    type: string
    sql: ${TABLE}.original_filename

  - dimension: page_count
    type: number
    sql: ${TABLE}.page_count

  - dimension: practice_fax_id
    type: number
    sql: ${TABLE}.practice_fax_id

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - dimension_group: process_complete
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.process_complete_time

  - dimension: process_result
    type: string
    sql: ${TABLE}.process_result

  - dimension_group: process_start
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.process_start_time

  - dimension: process_state
    type: string
    sql: ${TABLE}.process_state

  - dimension_group: received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_time

  - dimension: source
    type: string
    sql: ${TABLE}.source

  - dimension: subject
    type: string
    sql: ${TABLE}.subject

  - dimension: to_company
    type: string
    sql: ${TABLE}.to_company

  - dimension: to_name
    type: string
    sql: ${TABLE}.to_name

  - dimension: to_number
    type: string
    sql: ${TABLE}.to_number

  - dimension_group: transmit
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.transmit_time

  - measure: count
    type: count
    drill_fields: [id, original_filename, to_name]

