- view: messaging_threadmessage
  label: Messages Sent
  sql_table_name: el8_app_1.messaging_threadmessage
  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: number
    sql: ${TABLE}.id

  - dimension: body
    hidden: true
    type: string
    sql: ${TABLE}.body

  - dimension_group: send
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.send_date

  - dimension: sender_user_id
    type: number
    sql: ${TABLE}.sender_id

  - dimension: thread_id
    type: number
    sql: ${TABLE}.thread_id

  - dimension: to_document_id
    hidden: true
    type: number
    sql: ${TABLE}.to_document_id
    
  - dimension: practice_name 
    sql: ${entities_userprofile.practice_name}
    
  - dimension: practice_id 
    sql: ${entities_practice.id}    
    
  - dimension: provider_name
    sql: CONCAT(${practicians_physician.first_name},' ', ${practicians_physician.last_name})  
    
  - dimension: user_type
    sql: ${entities_userprofile.user_type}
    
  - dimension: provider_specialty
    sql: ${shareable_medicalspecialty.name}
    
  - dimension: practice_specialty
    sql: ${entities_practice.specialty}
    
  - dimension_group: provider_credentialed
    type: time
    timeframes: [time, date, week, month]
    sql: ${entities_userprofile.timecredentialed_date}
  
  - dimension: enterprise
    type: string
    sql: ${entities_enterprise.name}

  - dimension: practice_state
    type: string
    sql: ${entities_practice.state}
    
  - dimension: practice_city
    type: string
    sql: ${entities_practice.city}
    
  - dimension: practice_ZIP
    type: string
    sql: ${entities_practice.zip}    
    
  - dimension: emr_type
    type: string
    sql: ${entities_practice.emr_type}    
    
  - dimension: app_type
    type: string
    sql: ${entities_practice.app_type}

  - measure: count
    type: count
    drill_fields: [id, sender_user_id, provider_name, provider_specialty, provider_credentialed, practice_id, practice_name, enterprise, practice_specialty, practice_city, practice_state, practice_ZIP, emr_type, app_type]

