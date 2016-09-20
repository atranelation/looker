- view: patients_patientproviderteammember
  sql_table_name: el8_app_1.patients_patientproviderteammember
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension_group: activity_summary_last_refreshed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.activity_summary_last_refreshed

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension_group: earliest_activity
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.earliest_activity

  - dimension: group
    type: string
    sql: ${TABLE}.`group`

  - dimension_group: latest_activity
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.latest_activity

  - dimension: physician_id
    type: number
    sql: ${TABLE}.physician_id

  - dimension: rank
    type: number
    sql: ${TABLE}.rank

  - dimension: team_id
    type: number
    sql: ${TABLE}.team_id

  - dimension: treatment_reason
    type: string
    sql: ${TABLE}.treatment_reason

  - measure: count
    type: count
    drill_fields: [id]
    
  - measure: avergae
    type: average
    sql: average(count(${TABLE}.id))
    drill_fields: [id]

