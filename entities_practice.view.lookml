- view: entities_practice
  label: Practices
  sql_table_name: el8_app_1.entities_practice
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: address
    type: string
    sql: ${TABLE}.address

  - dimension: app_type
    type: string
    sql: ${TABLE}.app_type

  - dimension: campaign
    hidden: true
    type: string
    sql: ${TABLE}.campaign

  - dimension: category
    type: string
    sql: ${TABLE}.category

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: current_impl_manager_id
    hidden: true
    type: number
    sql: ${TABLE}.current_impl_manager_id

  - dimension: default_timezone
    type: string
    sql: ${TABLE}.default_timezone

  - dimension: emr_type
    type: string
    sql: ${TABLE}.emr_type

  - dimension: enterprise_id
    type: number
    sql: ${TABLE}.enterprise_id

  - dimension: fax
    type: string
    sql: ${TABLE}.fax

  - dimension: feedback_email
    hidden: true
    type: string
    sql: ${TABLE}.feedback_email

  - dimension: impl_doc_url
    hidden: true
    type: string
    sql: ${TABLE}.impl_doc_url

  - dimension: practice_name
    type: string
    sql: ${TABLE}.name

  - dimension: phone
    type: string
    sql: ${TABLE}.phone

  - dimension: specialty
    type: string
    sql: ${TABLE}.specialty

  - dimension: state
    type: string
    sql: ${TABLE}.state

  - dimension: suite
    hidden: true
    type: string
    sql: ${TABLE}.suite

  - dimension: zip
    type: string
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id, name, specialty]

