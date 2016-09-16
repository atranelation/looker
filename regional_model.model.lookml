- connection: app-slave

- include: "*.view.lookml"       # include all views in this project
- include: "*.dashboard.lookml"  # include all dashboards in this project

- explore: entities_userprofile
  label: 'Users'
  joins:
  - join: entities_practice
    type: left_outer
    relationship: many_to_one 
    sql_on: ${entities_practice.id} = ${entities_userprofile.practice_id}
    fields: [app_type, emr_type, practice_name]
  - join: practicians_officestaff
    type: left_outer
    relationship: many_to_one 
    sql_on: ${practicians_officestaff.id} = ${entities_userprofile.id}
    fields: [id]
  - join: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${auth_user.id} = ${entities_userprofile.user_id}
    fields: [is_staff]  
  - join: practicians_physician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_physician.id} = ${entities_userprofile.id}
    fields: [id]  
  - join: practicians_practicetophysician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_practicetophysician.physician_id} = ${entities_userprofile.id} AND ${practicians_practicetophysician.practice_id} = ${entities_userprofile.practice_id} 
    fields: [account_type]
  - join: shareable_medicalspecialty
    type: left_outer
    relationship: many_to_one
    sql_on: ${shareable_medicalspecialty.id} = ${practicians_physician.specialty_id}
  - join: implementation_manager
    from: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_practice.current_impl_manager_id} = ${implementation_manager.id}
    fields: [first_name, last_name]
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}

- explore: entities_practice
  label: Practices
  joins:
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}
    fields: []

- explore: patients_patient
  label: Patients
  joins: 
  - join: patients_patientaddress
    type: inner
    relationship: one_to_one
    sql_on: ${patients_patient.id} = ${patients_patientaddress.patient_id}


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}
