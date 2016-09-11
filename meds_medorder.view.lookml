- view: meds_medorder
  hidden: true
  sql_table_name: el8_app_1.meds_medorder
  fields:

  - dimension: auth_refills
    type: number
    sql: ${TABLE}.auth_refills

  - dimension: auth_refills_qualifier
    type: string
    sql: ${TABLE}.auth_refills_qualifier

  - dimension: client_metadata
    type: string
    sql: ${TABLE}.client_metadata

  - dimension: directions
    type: string
    sql: ${TABLE}.directions

  - dimension: displayed_medication_name
    type: string
    sql: ${TABLE}.displayed_medication_name

  - dimension: doc_id
    type: number
    sql: ${TABLE}.doc_id

  - dimension: documenting_personnel_id
    type: number
    sql: ${TABLE}.documenting_personnel_id

  - dimension: drug_interaction_id
    type: number
    sql: ${TABLE}.drug_interaction_id

  - dimension: eligibility_id
    type: number
    sql: ${TABLE}.eligibility_id

  - dimension: fulfillment_id
    type: number
    sql: ${TABLE}.fulfillment_id

  - dimension: fulfillment_required
    type: yesno
    sql: ${TABLE}.fulfillment_required

  - dimension: indication
    type: string
    sql: ${TABLE}.indication

  - dimension: is_self_prescribed
    type: yesno
    sql: ${TABLE}.is_self_prescribed

  - dimension: medication_id
    type: number
    sql: ${TABLE}.medication_id

  - dimension: medication_print_type
    type: string
    sql: ${TABLE}.medication_print_type

  - dimension: medication_type
    type: string
    sql: ${TABLE}.medication_type

  - dimension: notes
    type: string
    sql: ${TABLE}.notes

  - dimension: num_samples
    type: string
    sql: ${TABLE}.num_samples

  - dimension: origin
    type: number
    sql: ${TABLE}.origin

  - dimension: packaged_medication_id
    type: number
    sql: ${TABLE}.packaged_medication_id

  - dimension: pharmacy_instructions
    type: string
    sql: ${TABLE}.pharmacy_instructions

  - dimension: prescribing_physician_id
    type: number
    sql: ${TABLE}.prescribing_physician_id

  - dimension: prescribing_user_id
    type: number
    sql: ${TABLE}.prescribingUser_id

  - dimension: qty
    type: number
    sql: ${TABLE}.qty

  - dimension: qty_units
    type: string
    sql: ${TABLE}.qty_units

  - dimension: rx_item_id
    type: number
    sql: ${TABLE}.rx_item_id

  - dimension: short_medication_name
    type: string
    sql: ${TABLE}.short_medication_name

  - dimension_group: start
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.start_date

  - dimension: substitutions
    type: number
    sql: ${TABLE}.substitutions

  - dimension: supervising_physician_id
    type: number
    sql: ${TABLE}.supervising_physician_id

  - dimension: thread_id
    type: number
    sql: ${TABLE}.thread_id

  - dimension: type
    type: string
    sql: ${TABLE}.type

  - measure: count
    type: count
    drill_fields: [displayed_medication_name, short_medication_name]

