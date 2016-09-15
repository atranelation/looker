- connection: app-slave

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

- explore: shareable_imocode
  label: imo codes with ic9, icd10, and hcc
  joins:
  - join: shareable_imocodetoicd10
    type: left_outer
    relationship: one_to_one
    sql_on: ${shareable_imocode.id} = ${shareable_imocodetoicd10.imo_code_id} 
    fields: []
  - join: shareable_icd10code
    type: left_outer
    relationship: one_to_one
    sql_on: ${shareable_imocodetoicd10.icd10_code_id} = ${shareable_icd10code.id} 
    fields: []
  - join: shareable_imocodetoicd9
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_imocode.id} = ${shareable_imocodetoicd9.imo_code_id}
  - join: shareable_icd10code_hcc_categories
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_icd10code_hcc_categories.icd10code_id} = ${shareable_icd10code.id}
  - join: shareable_hcccategory
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_hcccategory.id} = ${shareable_icd10code_hcc_categories.hcccategory_id}    

- explore: patient_problem_list
  joins:
  - join: shareable_imocode
    type: left_outer
    relationship: one_to_one
    sql_on: ${shareable_imocode.id} = ${patient_problem_list.imo_id} 
    fields: []
  - join: shareable_imocodetoicd10
    type: left_outer
    relationship: one_to_one
    sql_on: ${shareable_imocode.id} = ${shareable_imocodetoicd10.imo_code_id} 
    fields: []
  - join: shareable_icd10code
    type: left_outer
    relationship: one_to_one
    sql_on: ${shareable_imocodetoicd10.icd10_code_id} = ${shareable_icd10code.id} 
    fields: []
  - join: shareable_imocodetoicd9
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_imocode.id} = ${shareable_imocodetoicd9.imo_code_id}
  - join: shareable_icd10code_hcc_categories
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_icd10code_hcc_categories.icd10code_id} = ${shareable_icd10code.id}
  - join: shareable_hcccategory
    type: left_outer
    relationship: one_to_one
    fields: []
    sql_on: ${shareable_hcccategory.id} = ${shareable_icd10code_hcc_categories.hcccategory_id}    

- view: patient_problem_list
  derived_table:
    sql:
      SELECT i.id, i.patient_id, pr.id AS practiceID, pr.name AS practiceName, ee.name AS enterpriseName,c.recordDate AS addressedDate, imo.id AS imoID, ppicd9.icd9code_id, ptp.primaryPhysicianUser_id AS physician_user_id
        FROM patients_patientitem i
            JOIN reference_patientproblem p ON p.item_id = i.id 
            JOIN patients_practicetopatient ptp ON ptp.patient_id=i.patient_id and ptp.role=0 
            JOIN entities_practice pr on pr.id=ptp.practice_id 
            LEFT JOIN entities_enterprise ee ON ee.id = pr.enterprise_id
            JOIN auditlogging_actionlog c on c.id=i.createLog_id 
            LEFT JOIN reference_patientproblem_imo_codes ppimo on ppimo.patientproblem_id=i.id
            LEFT JOIN shareable_imocode imo on imo.id=ppimo.imocode_id
            JOIN entities_practicesettings ps on ps.practice_id=pr.id
            LEFT JOIN reference_patientproblem_icd9_codes ppicd9 ON ppicd9.patientproblem_id = i.id
        WHERE recordDate > '2013-01-01'    
    sql_trigger_value: SELECT CURDATE()
    indexes: [addressedDate, id]
    
  fields:
  - dimension: id
    type: number                 
    primary_key: true
    sql: ${TABLE}.id
    
  - dimension: patient_id
    type: number                 
    sql: ${TABLE}.patient_id
    
  - dimension: practice_id
    type: number                 
    sql: ${TABLE}.practiceID

  - dimension: physician_user_id
    type: number                 
    sql: ${TABLE}.physician_user_id

  - dimension_group: addressed
    type: time
    timeframes: [time, date, month]
    sql: ${TABLE}.addressedDate
    
  - dimension: imo_id
    type: number                 
    sql: ${TABLE}.imoID

  - dimension: icd9code
    type: number                 
    sql: ${TABLE}.icd9code_id
  
  - dimension: institutional_factor
    type: number
    sql: ${shareable_hcccategory.institutional_factor}

  - dimension: community_factor
    type: number
    sql: ${shareable_hcccategory.community_factor}
    
  - dimension: label
    type: string
    sql: ${shareable_hcccategory.label}

  - dimension: icd10_code
    type: number
    sql: ${shareable_imocodetoicd10.icd10_code_id}

  - measure: count
    type: count
    drill_fields: [id, patient_id, pratice_id, addressed, imo_id, icd9code]


    
    


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}
