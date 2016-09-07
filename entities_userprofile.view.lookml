- view: entities_userprofile
  sql_table_name: el8_app_1.entities_userprofile
  fields:

  - dimension: id
    primary_key: true
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
    type: number
    sql: ${TABLE}.practice_id

  - dimension_group: timecredentialed
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.time_credentialed

  - dimension_group: timeemailverified
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
  
  - dimension: emr_type 
    sql: ${entities_practice.emr_type}

  - dimension: app_type 
    sql: ${entities_practice.app_type}
    
  - dimension: is_office_staff 
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
    type: yesno
    sql: ${practicians_physician.id} IS NOT NULL

  - dimension: account_type
    sql: ${practicians_practicetophysician.account_type}

  - dimension: user_type
    sql: 
      CASE WHEN ${TABLE}.is_elation_staff = 0 AND ${TABLE}.time_credentialed IS NOT NULL AND AND ${TABLE}.time_email_verified IS NOT NULL ${entities_practice.app_type} = 'emr' AND ${entities_practice.emr_type} = 'practicing' 
            AND ${auth_user.is_staff} = 0 AND ${auth_user.is_active} = 1 AND ${practicians_practicetophysician.account_type} = 'regular' THEN 'paid provider'
           WHEN ${practicians_officestaff.id} IS NOT NULL AND ${TABLE}.is_elation_staff = 0 AND ${entities_practice.app_type} = 'emr' AND ${entities_practice.emr_type} = 'practicing' THEN 'staff'
           WHEN ${entities_practice.app_type} = 'access' OR ${entities_practice.emr_type} = 'passport' THEN 'provider passport'
           WHEN ${entities_practice.app_type} = 'passport' THEN 'patient'
        ELSE NULL
      END

  - dimension: physician_name
    sql: CONCAT(${practicians_physician.first_name}, ${practicians_physician.last_name})  
    
  - dimension: physician_specialty
    sql: ${shareable_medicalspecialty.name}
  
  - measure: count
    type: count
    drill_fields: [id, practice_name, physician_name, user_type, physician_specialty]

