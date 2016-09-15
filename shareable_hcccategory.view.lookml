- view: shareable_hcccategory
  sql_table_name: el8_app_1.shareable_hcccategory
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: code
    type: string
    sql: ${TABLE}.code

  - dimension: community_factor
    type: number
    sql: ${TABLE}.community_factor

  - dimension: institutional_factor
    type: number
    sql: ${TABLE}.institutional_factor

  - dimension: label
    type: string
    sql: ${TABLE}.label

  - dimension: parent_id
    type: number
    sql: ${TABLE}.parent_id

  - measure: count
    type: count
    drill_fields: [id]

