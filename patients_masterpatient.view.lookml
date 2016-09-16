- view: patients_masterpatient
  sql_table_name: el8_app_1.patients_masterpatient
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - measure: count
    type: count
    drill_fields: [id]

