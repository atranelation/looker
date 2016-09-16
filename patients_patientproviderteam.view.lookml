- view: patients_patientproviderteam
  sql_table_name: el8_app_1.patients_patientproviderteam
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: practice_to_patient_id
    type: number
    sql: ${TABLE}.practice_to_patient_id

  - measure: count
    type: count
    drill_fields: [id]

