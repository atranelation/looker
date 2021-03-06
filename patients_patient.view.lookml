- view: patients_patient
  sql_table_name: el8_app_1.patients_patient
  sets: 
    practice_info:
      - practice_id
      - practice_name
      - practice_specialty
      - enterprise
      - practice_city
      - practice_state
      - practice_ZIP
      - emr_type
      - app_type
    provider_info:
      - provider_user_id
      - provider_name
      - provider_specialty
    patient_info:
      - id
      - age
      - sex
  fields:

  - dimension: id
    label: patient_id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: chart_number
    hidden: true
    type: string
    sql: ${TABLE}.chartNumber

  - dimension: create_log_id
    hidden: true
    type: number
    sql: ${TABLE}.createLog_id

  - dimension: delete_log_id
    hidden: true
    type: number
    sql: ${TABLE}.deleteLog_id

  - dimension: demo
    hidden: true
    type: yesno
    sql: ${TABLE}.demo

  - dimension_group: dob
    type: time
    hidden: true
    timeframes: [date, week, month, year]
    convert_tz: false
    sql: ${TABLE}.dob

  - dimension: ethnicity
    type: number
    sql: ${TABLE}.ethnicity

  - dimension: first_name
    hidden: true
    type: string
    sql: ${TABLE}.firstName

  - dimension_group: last_modified
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_modified

  - dimension: last_name
    hidden: true
    type: string
    sql: ${TABLE}.lastName

  - dimension: marital_status
    hidden: true
    type: string
    sql: ${TABLE}.maritalStatus

  - dimension: master_id
    type: number
    sql: ${TABLE}.master_id
    
  - dimension: master_patient_id
    hidden: true
    type: number
    sql: CASE WHEN ${TABLE}.master_id IS NOT NULL THEN ${TABLE}.master_id
          ELSE ${TABLE}.id
        END

  - dimension: middle_name
    hidden: true
    type: string
    sql: ${TABLE}.middleName

  - dimension: notes
    hidden: true
    type: string
    sql: ${TABLE}.notes

  - dimension: occupation
    hidden: true
    type: string
    sql: ${TABLE}.occupation

  - dimension: preferred_contact
    hidden: true
    type: string
    sql: ${TABLE}.preferredContact

  - dimension: preferred_language_id
    hidden: true
    type: number
    sql: ${TABLE}.preferredLanguage_id

  - dimension: preferred_notification
    hidden: true
    type: string
    sql: ${TABLE}.preferred_notification

  - dimension: prefix
    hidden: true
    type: string
    sql: ${TABLE}.prefix

  - dimension: primary_address_id
    hidden: true
    type: number
    sql: ${TABLE}.primary_address_id

  - dimension: race
    type: number
    sql: ${TABLE}.race

  - dimension: secondary_race
    type: number
    sql: ${TABLE}.secondary_race

  - dimension: sex
    type: string
    sql: ${TABLE}.sex
  
  - dimension: age
    type: number
    sql: TRUNCATE(DATEDIFF(CURDATE(), ${TABLE}.dob)/365.25, 0)
    value_format: '0'

  - dimension: ssn
    hidden: true
    type: string
    sql: ${TABLE}.ssn

  - dimension: suffix
    hidden: true
    type: string
    sql: ${TABLE}.suffix

  - dimension: verified
    hidden: true
    type: yesno
    sql: ${TABLE}.verified
    
  - dimension: practice_id 
    type: number
    sql: ${entities_practice.id}

  - dimension: practice_name 
    type: string
    sql: ${entities_practice.practice_name}
    
  - dimension: practice_specialty
    type: string
    sql: ${entities_practice.specialty}
    
  - dimension: enterprise
    type: string
    sql: ${entities_enterprise.name}

  - dimension: practice_state
    type: string
    map_layer: us_states
    sql: ${entities_practice.state}
    
  - dimension: practice_city
    type: string
    sql: ${entities_practice.city}
    
  - dimension: practice_ZIP
    type: zipcode
    map_layer: us_zipcode_tabulation_areas
    sql: ${entities_practice.zip}    
    
  - dimension: practice_emr_type
    type: string
    sql: ${entities_practice.emr_type}    
    
  - dimension: practice_app_type
    type: string
    sql: ${entities_practice.app_type}    

  - dimension: provider_user_id
    type: number
    sql:  ${practicians_physician.user_id}

  - dimension: provider_name
    sql: CONCAT(${practicians_physician.first_name}, ' ', ${practicians_physician.last_name})  
  
  - dimension: provider_specialty
    sql: ${shareable_medicalspecialty.name}

  - dimension: patient_state
    type: string
    map_layer: us_states
    sql: ${patients_patientaddress.state}
    
  - dimension: patient_city
    type: string
    sql: ${patients_patientaddress.city}
    
  - dimension: patient_ZIP
    type: zipcode
    map_layer: us_zipcode_tabulation_areas
    sql: ${patients_patientaddress.zip}  
  
  - dimension: number_of_chart_collaborators
    type: number
    sql: CASE WHEN ${custom_collaborators_by_patient_id.NumberOfCollaborators} IS NULL THEN 0
              ELSE ${custom_collaborators_by_patient_id.NumberOfCollaborators}
            END
  

#   - dimension_group: chart_created
#     type: time
#     timeframes: [date, month, year]
#     sql: ${auditlogging_actionlog.record}

  - measure: patient_count
    type: count_distinct 
    sql: ${patients_patient.master_patient_id}
    drill_fields: [patient_info, practice_info]

  - measure: chart_count
    type: count
    drill_fields: [patient_info, practice_info]