- view: practicians_canonicalphysician
  sql_table_name: el8_app_1.practicians_canonicalphysician
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

  - dimension: address
    type: string
    sql: ${TABLE}.address

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: contact_type
    type: string
    sql: ${TABLE}.contact_type

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: credentials
    type: string
    sql: ${TABLE}.credentials

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: direct_address
    type: string
    sql: ${TABLE}.direct_address

  - dimension_group: dob
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension_group: e_verification
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.e_verification_date

  - dimension: email
    type: string
    sql: ${TABLE}.email

  - dimension: fax
    type: string
    sql: ${TABLE}.fax

  - dimension: first_name
    type: string
    sql: ${TABLE}.firstName

  - dimension: insurance_accepted
    type: string
    sql: ${TABLE}.insurance_accepted

  - dimension: last_name
    type: string
    sql: ${TABLE}.lastName

  - dimension: middle_name
    type: string
    sql: ${TABLE}.middleName

  - dimension: npi
    type: string
    sql: ${TABLE}.npi

  - dimension: org_name
    type: string
    sql: ${TABLE}.org_name

  - dimension: phone
    type: string
    sql: ${TABLE}.phone

  - dimension: practicing_status
    type: string
    sql: ${TABLE}.practicing_status

  - dimension: prefix
    type: string
    sql: ${TABLE}.prefix

  - dimension: profile
    type: string
    sql: ${TABLE}.profile

  - dimension: sex
    type: string
    sql: ${TABLE}.sex

  - dimension: specialty_id
    type: number
    sql: ${TABLE}.specialty_id

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: suffix
    type: string
    sql: ${TABLE}.suffix

  - dimension: suite
    type: string
    sql: ${TABLE}.suite

  - dimension: zip
    type: string
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id, org_name, first_name, last_name, middle_name]

