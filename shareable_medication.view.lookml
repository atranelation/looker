- view: shareable_medication
  hidden: true
  sql_table_name: el8_app_1.shareable_medication
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: available_strengths
    type: string
    sql: ${TABLE}.availableStrengths

  - dimension: brand_name
    type: string
    sql: ${TABLE}.brandName

  - dimension: brand_type
    type: string
    sql: ${TABLE}.brand_type

  - dimension: create_log_id
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: creation_type
    type: string
    sql: ${TABLE}.creationType

  - dimension: deadescription
    type: string
    sql: ${TABLE}.DEAdescription

  - dimension: display_name
    type: string
    sql: ${TABLE}.displayName

  - dimension: form
    type: string
    sql: ${TABLE}.form

  - dimension: generic_name
    type: string
    sql: ${TABLE}.genericName

  - dimension: is_controlled
    type: yesno
    sql: ${TABLE}.isControlled

  - dimension: is_drug
    type: yesno
    sql: ${TABLE}.isDrug

  - dimension: is_maintenance_drug
    type: yesno
    sql: ${TABLE}.is_maintenance_drug

  - dimension_group: market_end
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.marketEndDate

  - dimension: medispanddid
    type: string
    sql: ${TABLE}.medispanddid

  - dimension: medispandnid
    type: string
    sql: ${TABLE}.medispandnid

  - dimension: medispanrdid
    type: string
    sql: ${TABLE}.medispanrdid

  - dimension_group: obsolete
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.obsoleteDate

  - dimension: practice_created_id
    type: number
    sql: ${TABLE}.practice_created_id

  - dimension: preferred_alternative_medication_id
    type: number
    sql: ${TABLE}.preferredAlternativeMedication_id

  - dimension: preferred_alternative_sig
    type: string
    sql: ${TABLE}.preferredAlternativeSig

  - dimension: preferred_medispandnid
    type: string
    sql: ${TABLE}.preferred_medispandnid

  - dimension: premig_medication_id
    type: number
    sql: ${TABLE}.premig_medication_id

  - dimension: route
    type: string
    sql: ${TABLE}.route

  - dimension: strength
    type: string
    sql: ${TABLE}.strength

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - measure: count
    type: count
    drill_fields: [id, generic_name, brand_name, display_name]

