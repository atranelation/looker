- view: shareable_icd10code_hcc_categories
  sql_table_name: el8_app_1.shareable_icd10code_hcc_categories
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: hcccategory_id
    type: number
    sql: ${TABLE}.hcccategory_id

  - dimension: icd10code_id
    type: number
    sql: ${TABLE}.icd10code_id

  - measure: count
    type: count
    drill_fields: [id]

