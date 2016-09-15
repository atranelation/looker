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

  - measure: count
    hidden: true
    type: count
    drill_fields: [id]

- explore: patient_problem_list
  
- view: patient_problem_list
  derived_table:
    sql:
      SELECT i.id, i.patient_id, pr.id AS practiceID, pr.name AS practiceName, ee.name AS enterpriseName,c.recordDate AS addressedDate, imo.id  AS imoID, ppicd9.icd9code_id, ptp.primaryPhysicianUser_id AS physician_user_id
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
    
  - measure: count
    type: count
    drill_fields: [id, patient_id, pratice_id, addressed, imo_id, icd9code]


