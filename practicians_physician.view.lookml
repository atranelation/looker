- view: practicians_physician
  sql_table_name: el8_app_1.practicians_physician
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: accepting_insurance
    type: yesno
    sql: ${TABLE}.accepting_insurance

  - dimension: accepting_new_patients
    type: yesno
    sql: ${TABLE}.accepting_new_patients

  - dimension: practice_id
    type: number
    sql: ${TABLE}.access_practice_id

  - dimension: user_id
    type: number
    sql: ${TABLE}.access_user_id

  - dimension: address
    type: string
    sql: ${TABLE}.address

  - dimension: alternate_id
    hidden: true
    type: number
    sql: ${TABLE}.alternate_id

  - dimension: back_office_phone
    type: string
    sql: ${TABLE}.back_office_phone

  - dimension: canonical_id
    type: number
    sql: ${TABLE}.canonical_id

  - dimension: canonical_non_mapping_state
    type: string
    sql: ${TABLE}.canonical_non_mapping_state

  - dimension: cell_phone
    hidden: true
    type: string
    sql: ${TABLE}.cell_phone

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: cms_npi
    type: string
    sql: ${TABLE}.cms_npi

  - dimension: contact_type
    type: string
    sql: ${TABLE}.contact_type

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: credentials
    type: string
    sql: ${TABLE}.credentials

  - dimension: delete_log_id
    hidden: true
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: direct_address
    type: string
    sql: ${TABLE}.direct_address

  - dimension_group: dob
    hidden: true
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: fax
    type: string
    sql: ${TABLE}.fax

  - dimension: first_name
    type: string
    sql: ${TABLE}.firstName

  - dimension: from_npi_db
    type: yesno
    sql: ${TABLE}.from_npi_db

  - dimension: insurance_accepted
    type: string
    sql: ${TABLE}.insurance_accepted

  - dimension: last_name
    type: string
    sql: ${TABLE}.lastName

  - dimension: middle_name
    type: string
    sql: ${TABLE}.middleName

  - dimension: notes
    type: string
    sql: ${TABLE}.notes

  - dimension: org_name
    type: string
    sql: ${TABLE}.org_name

  - dimension: phone
    type: string
    sql: ${TABLE}.phone

  - dimension: practice_created_id
    hidden: true
    type: number
    sql: ${TABLE}.practice_created_id

  - dimension: prefix
    hidden: true
    type: string
    sql: ${TABLE}.prefix

  - dimension: sex
    hidden: true
    type: string
    sql: ${TABLE}.sex

  - dimension: specialty_id
    type: number
    sql: ${TABLE}.specialty_id

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: suffix
    hidden: true
    type: string
    sql: ${TABLE}.suffix

  - dimension: suite
    hidden: true
    type: string
    sql: ${TABLE}.suite

  - dimension: verified
    type: yesno
    sql: ${TABLE}.verified

  - dimension: zip
    type: string
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id, org_name, middle_name, last_name, first_name, practice_id]

