- view: shareable_imocode
  sql_table_name: el8_app_1.shareable_imocode
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: code
    type: string
    sql: ${TABLE}.code

  - dimension: delete_log_id
    hidden: true
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: description
    type: string
    sql: ${TABLE}.description

  - dimension: snomed_id
    type: number
    sql: ${TABLE}.snomed_id
  
  - dimension: institutional_factor
    type: number
    sql: ${shareable_hcccategory.institutional_factor}

  - dimension: community_factor
    type: number
    sql: ${shareable_hcccategory.community_factor}
    
  - dimension: label
    type: string
    sql: ${shareable_hcccategory.label}

  - dimension: icd9_code
    type: number
    sql: ${shareable_imocodetoicd9.icd9_code_id}

  - dimension: icd10_code
    type: number
    sql: ${shareable_imocodetoicd10.icd10_code_id}

  - measure: count
    type: count
    drill_fields: [id]

