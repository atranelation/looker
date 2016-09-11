- view: filemgr_incomingfilegroup
  label: images
  sql_table_name: el8_app_1.filemgr_incomingfilegroup
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: content_type
    hidden: true
    type: string
    sql: ${TABLE}.content_type

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: fax_id
    hidden: true
    type: number
    sql: ${TABLE}.fax_id

  - dimension: file_path
    hidden: true
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
    hidden: true
    type: string
    sql: ${TABLE}.original_filename

  - dimension: page_count
    type: number
    sql: ${TABLE}.page_count

  - dimension: practice_fax_id
    hidden: true
    type: number
    sql: ${TABLE}.practice_fax_id

  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id

  - dimension_group: process_complete
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.process_complete_time

  - dimension: process_result
    hidden: true
    type: string
    sql: ${TABLE}.process_result

  - dimension_group: process_start
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.process_start_time

  - dimension: process_state
    hidden: true
    type: string
    sql: ${TABLE}.process_state

  - dimension_group: image_received
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.received_time

  - dimension: source
    type: string
    sql: ${TABLE}.source

  - dimension: subject
    hidden: true
    type: string
    sql: ${TABLE}.subject

  - dimension: to_company
    hidden: true
    type: string
    sql: ${TABLE}.to_company

  - dimension: to_name
    hidden: true
    type: string
    sql: ${TABLE}.to_name

  - dimension: to_number
    hidden: true
    type: string
    sql: ${TABLE}.to_number

  - dimension_group: transmit
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.transmit_time

  - measure: count
    type: count
    drill_fields: [id, practice_id]

