- view: entities_userprofile
  label: Elation User Information
  sql_table_name: el8_app_1.entities_userprofile
  fields:

  - dimension: id
    hidden: true
    primary_key: true
    type: number
    sql: ${TABLE}.id
    
  - dimension: url_id
    type: number
    sql: ${TABLE}.id
# 
#   - dimension: emergency_on
#     type: yesno
#     sql: ${TABLE}.emergency_on
# 
#   - dimension: has_chart_access
#     type: yesno
#     sql: ${TABLE}.has_chart_access
# 
  - dimension: is_elation_staff
    type: yesno
    hidden: true
    sql: ${TABLE}.is_elation_staff

  - dimension: is_emergency
    type: yesno
    hidden: true
    sql: ${TABLE}.is_emergency

  - dimension: is_practice_admin
    type: yesno
    hidden: true
    sql: ${TABLE}.is_practice_admin

#   - dimension: opt_email_daily
#     type: yesno
#     sql: ${TABLE}.optEmailDaily
# 
#   - dimension: opt_email_weekly
#     type: yesno
#     sql: ${TABLE}.optEmailWeekly

  - dimension: practice_id
    hidden: true
    type: number
    sql: ${TABLE}.practice_id

  - dimension_group: timecredentialed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_credentialed

  - dimension_group: email_verified
    hidden: true
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_email_verified

  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id

#   - dimension_group: verify
#     type: time
#     timeframes: [time, date, week, month]
#     sql: ${TABLE}.verifyDate
#     
  - dimension: practice_name 
    sql: ${entities_practice.practice_name}
  
  - dimension: practice_city
    sql: ${entities_practice.city}
    
  - dimension: practice_state
    sql: ${entities_practice.city}

  - dimension: practice_ZIP
    type: zipcode
    sql: ${entities_practice.zip}

  - dimension: emr_type 
    hidden: true
    sql: ${entities_practice.emr_type}

  - dimension: app_type 
    hidden: true
    sql: ${entities_practice.app_type}
    
  - dimension: enterprise
    sql: ${entities_enterprise.name}  
    
  - dimension: is_office_staff 
    hidden: true
    type: yesno
    sql: ${practicians_officestaff.id} IS NOT NULL

  - dimension: is_staff 
    hidden: true
    type: yesno
    sql: ${auth_user.is_staff}
    
  - dimension: is_active 
    hidden: true
    type: yesno
    sql: ${auth_user.is_active}

  - dimension: is_physician
    hidden: true
    type: yesno
    sql: ${practicians_physician.id} IS NOT NULL

  - dimension: account_type
    sql: ${practicians_practicetophysician.account_type}

  - dimension: user_type
    sql: 
      CASE WHEN ${TABLE}.is_elation_staff = 0 AND ${TABLE}.time_credentialed IS NOT NULL AND ${TABLE}.time_email_verified IS NOT NULL AND ${entities_practice.app_type} = 'emr' AND ${entities_practice.emr_type} = 'practicing' 
            AND ${auth_user.is_staff} = 0 AND ${auth_user.is_active} = 1 AND ${practicians_practicetophysician.account_type} = 'regular' THEN 'paid provider'
           WHEN ${practicians_officestaff.id} IS NOT NULL AND ${TABLE}.time_credentialed IS NOT NULL AND ${TABLE}.time_email_verified IS NOT NULL 
            AND ${TABLE}.is_elation_staff = 0 AND ${entities_practice.app_type} = 'emr' AND ${entities_practice.emr_type} = 'practicing' THEN 'staff'
           WHEN ${entities_practice.app_type} = 'access' OR ${entities_practice.emr_type} = 'passport' THEN 'provider passport'
           WHEN ${entities_practice.app_type} = 'passport' THEN 'patient'
        ELSE NULL
      END

  - dimension: provider_name
    sql: CONCAT(${practicians_physician.first_name}, ' ', ${practicians_physician.last_name})  
    
  - dimension: provider_specialty
    sql: ${shareable_medicalspecialty.name}
    
  - dimension: implementation_manager
    sql: CONCAT(${implementation_manager.first_name}, ' ', ${implementation_manager.last_name})

  - dimension_group: last_login
    type: time
    timeframes: [time, date, week, month]
    sql: ${auth_user.last_login_date}

  - dimension_group: joined
    type: time
    timeframes: [time, date, week, month]
    sql: ${auth_user.date_joined_date}
    
  - dimension: email
    type: string
    sql: ${auth_user.email}

  - measure: user_count
    type: count
    drill_fields: [id, practice_name, provider_name, user_type, provider_specialty, implementation_manager]
    
  - measure: cumulative_user_count
    type: running_total
    drill_fields: [id, practice_name, provider_name, user_type, provider_specialty, implementation_manager]

  - measure: unique_practice_count
    type: count_distinct
    sql: ${TABLE}.practice_id
    drill_fields: [practice_id, practice_name, enterprise, practice_specialty, practice_city, practice_state, practice_ZIP, emr_type, app_type]
      

