- view: shareable_imocodetoicd9
  sql_table_name: el8_app_1.shareable_imocodetoicd9
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: icd9_code_id
    type: number
    sql: ${TABLE}.icd9_code_id

  - dimension: imo_code_id
    type: number
    sql: ${TABLE}.imo_code_id

  - dimension: sequence
    type: number
    sql: ${TABLE}.sequence

  - measure: count
    type: count
    drill_fields: [id]

