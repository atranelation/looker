- view: practicians_canonicalphysician
  sql_table_name: el8_app_1.practicians_canonicalphysician
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension: accepting_insurance
    hidden: true
    type: yesno
    sql: ${TABLE}.accepting_insurance

  - dimension: accepting_new_patients
    hidden: true
    type: yesno
    sql: ${TABLE}.accepting_new_patients

  - dimension: address
    type: string
    sql: ${TABLE}.address

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: contact_type
    hidden: true
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
    hidden: true
    type: string
    sql: ${TABLE}.firstName

  - dimension: insurance_accepted
    hidden: true
    type: string
    sql: ${TABLE}.insurance_accepted

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.lastName

  - dimension: middle_name
    hidden: true
    type: string
    sql: ${TABLE}.middleName

  - dimension: provider_name
    type: string
    sql: CONCAT(${TABLE}.firstName, ' ', ${TABLE}.middleName, ' ', ${TABLE}.lastName)

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
    hidden: true
    type: string
    sql: ${TABLE}.prefix

  - dimension: profile
    hidden: true
    type: string
    sql: ${TABLE}.profile

  - dimension: sex
    hidden: true
    type: string
    sql: ${TABLE}.sex

  - dimension: specialty_id
    hidden: true
    type: number
    sql: ${TABLE}.specialty_id

  - dimension: specialty
    type: string
    sql: ${shareable_medicalspecialty.name}

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

  - dimension: zip
    type: string
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [npi, provider_name, specialty, city, state]

