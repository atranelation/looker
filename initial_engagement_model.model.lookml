- connection: app-slave

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: signed_visits
  joins: 
  - join: entities_userprofile
    type: left_outer
    relationship: many_to_one
    sql_on: ${signed_visits.user_id} = ${entities_userprofile.user_id}
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
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}

- view: signed_visits
  derived_table:
    sql:
      SELECT recordDate, d.id AS documentID, a.user_id AS user_id, d.documentDate As document_date
        FROM patients_document d
        LEFT JOIN auditlogging_actionlog a on d.signLog_id=a.id
          WHERE d.document_type=24 AND d.deleteLog_id is NULL
    sql_trigger_value: SELECT CURDATE()
    indexes: [recordDate, user_id, documentID]

  fields:
  - dimension: documentID
    type: number                 
    hidden: true
    primary_key: true
    sql: ${TABLE}.documentID
    
  - dimension: user_id
    type: number                 
    sql: ${TABLE}.user_id
    
  - dimension: practice_id
    type: number                 
    sql: ${entities_practice.id}
    
  - dimension: physician_name
    type: string                 
    sql: CONCAT(${practicians_physician.first_name}, ' ',  ${practicians_physician.last_name})  
    
  - dimension: practice_name 
    sql: ${entities_practice.practice_name}

  - dimension_group: signed_on
    type: time
    timeframes: [time, date, month]
    sql: ${TABLE}.recordDate
    
  - dimension_group: created_on
    type: time
    timeframes: [time, date, month]
    sql: ${TABLE}.document_date
  
  - dimension_group: credentialed_on
    type: time
    timeframes: [time, date, week, month]
    sql: ${entities_userprofile.timecredentialed_date}

  - measure: signed_visits_count
    type: count
    drill_fields: [user_id, physician_name, timecredentialed, practice_id, practice_name, implementation_manager]
  
  - measure: unique_user_count
    type: count_distinct
    sql: ${TABLE}.user_id
    drill_fields: [user_id, physician_name, timecredentialed, practice_id, practice_name, implementation_manager]


- explore: appointments
  joins: 
  - join: entities_userprofile
    type: left_outer
    relationship: many_to_one
    sql_on: ${appointments.user_id} = ${entities_userprofile.user_id}
    fields: []
  - join: entities_practice
    type: left_outer
    relationship: many_to_one 
    sql_on: ${entities_practice.id} = ${appointments.practice_id}
    fields: []
  - join: practicians_officestaff
    type: left_outer
    relationship: many_to_one 
    sql_on: ${practicians_officestaff.id} = ${entities_userprofile.id}
    fields: []
  - join: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${auth_user.id} = ${entities_userprofile.user_id}
    fields: []  
  - join: practicians_physician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_physician.id} = ${entities_userprofile.id}
    fields: []
  - join: practicians_practicetophysician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_practicetophysician.physician_id} = ${entities_userprofile.id} AND ${practicians_practicetophysician.practice_id} = ${entities_userprofile.practice_id} 
    fields: []
  - join: shareable_medicalspecialty
    type: left_outer
    relationship: many_to_one
    sql_on: ${shareable_medicalspecialty.id} = ${practicians_physician.specialty_id}
    fields: []
  - join: implementation_manager
    from: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_practice.current_impl_manager_id} = ${implementation_manager.id}
    fields: []
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}
    fields: []

- view: appointments
  derived_table:
    sql:
      SELECT appt.id AS `appointment_id`, appt.practice_id, appt.physician_user_id, al.recordDate, appt.appt_time, appt.duration, sas.status 
        FROM scheduler_appointment appt 
          JOIN auditlogging_actionlog al ON al.id=appt.createLog_id
          JOIN scheduler_appointmentstatus sas ON sas.appointment_id=appt.id 
          LEFT JOIN scheduler_appointmentstatus sas2 ON sas2.appointment_id=appt.id AND (sas.id < sas2.id OR sas.id = sas2.id) 
    sql_trigger_value: SELECT CURDATE()
    indexes: [recordDate, status, practice_id, physician_user_id]
    
  fields:
  - dimension: appointment_id
    type: number
    primary_key: true
    sql: ${TABLE}.appointment_id
    
  - dimension: practice_id
    type: number
    sql: ${TABLE}.practice_id
    
  - dimension: user_id
    type: number
    sql: ${TABLE}.physician_user_id
    
  - dimension_group: record
    type: time
    timeframes: [date, month, year]
    sql: ${TABLE}.recordDate
    
  - dimension_group: appointment
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.appt_time

  - dimension: duration
    type: number
    sql: ${TABLE}.duration
    
  - dimension: status
    type: string
    sql: ${TABLE}.status
    
  - dimension: practice_specialty 
    sql: ${entities_practice.specialty}

  - dimension: user_type    
    sql: ${entities_userprofile.user_type}

  - dimension: provider_name
    sql: CONCAT(${practicians_physician.first_name}, ' ', ${practicians_physician.last_name})  
  
  - dimension: provider_specialty
    sql: ${shareable_medicalspecialty.name}
    
  - dimension_group: provider_credentialed
    type: time
    timeframes: [time, date, week, month]
    sql: ${entities_userprofile.timecredentialed_date}

  - dimension: practice_name 
    sql: ${entities_practice.practice_name}
    
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
    drill_fields: [appointment_time, user_type, user_id, provider_name, provider_specialty, time_credentialed, practice_id, practice_name, enterprise, practice_specialty, practice_city, practice_state, practice_ZIP, emr_type, app_type]
    
- explore: entities_userloginattempt
  label: 'Log Ins'
  joins:
  - join: entities_userprofile
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_userloginattempt.user_id} = ${entities_userprofile.user_id} AND success = 1
    fields: []
  - join: entities_practice
    type: left_outer
    relationship: many_to_one 
    fields: []
    sql_on: ${entities_practice.id} = ${entities_userprofile.practice_id}
  - join: practicians_officestaff
    type: left_outer
    relationship: many_to_one 
    fields: []
    sql_on: ${practicians_officestaff.id} = ${entities_userprofile.id}
    fields: [id]
  - join: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${auth_user.id} = ${entities_userprofile.user_id}
    fields: []
  - join: practicians_physician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_physician.id} = ${entities_userprofile.id}
    fields: []
  - join: practicians_practicetophysician
    type: left_outer
    relationship: many_to_one
    sql_on: ${practicians_practicetophysician.physician_id} = ${entities_userprofile.id} AND ${practicians_practicetophysician.practice_id} = ${entities_userprofile.practice_id} 
    fields: []
  - join: shareable_medicalspecialty
    type: left_outer
    relationship: many_to_one
    sql_on: ${shareable_medicalspecialty.id} = ${practicians_physician.specialty_id}
    fields: []
  - join: implementation_manager
    from: auth_user
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_practice.current_impl_manager_id} = ${implementation_manager.id}
    fields: []
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}
    fields: []

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

- explore: filemgr_incomingfilegroup
  label: Images Received 
  joins:
  - join: entities_practice
    type: left_outer
    relationship: many_to_one 
    fields: []
    sql_on: ${entities_practice.id} = ${filemgr_incomingfilegroup.practice_id}
  - join: entities_enterprise
    type: left_outer
    relationship: many_to_one
    sql_on: ${entities_enterprise.id} = ${entities_practice.enterprise_id}
    fields: []
  
- explore: messaging_threadmessage
  label: Messages Sent
  joins:
  - join: patients_document
    type: inner
    relationship: many_to_one 
    sql_on: ${patients_document.id} = ${messaging_threadmessage.thread_id} AND ${patients_document.delete_log_id} IS NULL 
    
- explore: reports

- view: reports
  derived_table:
    sql:
      SELECT pd.id, pd.authoring_practice_id, pd.documentDate AS `report_date`, al1.recordDate AS `create_date`, al2.recordDate AS `sign_date`, 
        rlrg.id IS NOT NULL AS `contains_lab_values`
        FROM reports_report rr 
          JOIN patients_document pd ON pd.id = rr.doc_id 
          JOIN auditlogging_actionlog al1 on al1.id = pd.createLog_id 
          JOIN auditlogging_actionlog al2 on al2.id = pd.signLog_id 
          LEFT JOIN reports_labresultgrid rlrg on rlrg.labReport_id = pd.id 
    sql_trigger_value: SELECT CURDATE()
    indexes: [create_date, sign_date, report_date]
    
  fields:
  - dimension: id
    type: number
    primary_key: true
    sql: ${TABLE}.id
    
  - dimension: authoring_practice_id
    type: number
    sql: ${TABLE}.authoring_practice_id
    
  - dimension_group: report_date
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.report_date
    
  - dimension_group: create_date
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.create_date

  - dimension_group: sign_date
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.sign_date

  - dimension: contains_lab_values
    type: yesno
    sql: ${TABLE}.contains_lab_values

  - measure: count
    type: count
    drill_fields: [id]
    
- explore: prescriptions
  
- view: prescriptions
  derived_table:
    sql: 
      SELECT mm.doc_id, al1.recordDate AS create_date, al2.recordDate AS sign_date, mm.origin, med.isControlled AS `controlled_substance`, mmof.type = 'surescripts' AS `is_erx`, mmof.state IN ('failure', 'error') AS `erx_failed`
        FROM meds_medorder mm 
          JOIN patients_document pd ON pd.id = mm.doc_id 
          JOIN auditlogging_actionlog al1 on al1.id = pd.createLog_id 
          JOIN auditlogging_actionlog al2 on al2.id= pd.signLog_id 
          JOIN shareable_medication med on med.id = mm.medication_id
          LEFT JOIN meds_medorderfulfillment mmof ON mm.fulfillment_id = mmof.id
        WHERE pd.deleteLog_id IS NULL
    sql_trigger_value: SELECT CURDATE()
    indexes: [create_date, sign_date]
    
  fields:
  - dimension: user_id
    type: number
    sql: ${TABLE}.user_id
    
  - dimension_group: create_date
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.create_date

  - dimension_group: sign_date
    type: time
    timeframes: [time, date, month, year]
    sql: ${TABLE}.sign_date

  - dimension: origin
    sql: 
      CASE WHEN ${TABLE}.origin = 1 THEN 'written by Elation provider'
           WHEN ${TABLE}.origin = 2 THEN 'medication documented in Elation, prescribed elsewhere'
           WHEN ${TABLE}.origin = 3 THEN 'imported from Surescripts pharmacy fill data'
        ELSE NULL
      END
    
  - dimension: is_controlled_substance
    type: yesno
    sql: ${TABLE}.controlled_substance

  - dimension: is_erx
    type: yesno
    sql: ${TABLE}.is_erx
    
  - dimension: erx_failed
    type: yesno
    sql: ${TABLE}.erx_failed
    
  - measure: prescription_count
    type: count
    drill_fields: [user_id, is_erx, origin, is_controlled_substance]
      
- explore: letters
  
- view: letters
  derived_table:
    sql: 
      SELECT pd.id AS `letter_id`, pd.authoring_practice_id, alal.recordDate AS `sign_date`, ll.send_to_patient AS `to_patient`, ll.delivery_method, ll.fax_attachments, 
          ll.referral_order_id IS NOT NULL AS `is_referral`, ep.emr_type = 'passport' AS `is_from_patient`
        FROM letters_letter ll 
          JOIN patients_document pd ON pd.id = ll.doc_id 
          JOIN auditlogging_actionlog alal ON alal.id = pd.signLog_id 
          JOIN entities_practice ep on ep.id = pd.authoring_practice_id 
        WHERE pd.deleteLog_id IS NULL
    sql_trigger_value: SELECT CURDATE()
    indexes: [create_date, sign_date]

# - explore: access_accessaccountpreferences

# - explore: access_accessregistrationaction

# - explore: access_accessregistrationlink

# - explore: access_accessregistrationlinkevent

# - explore: access_accessregistrationlinkreadlog

# - explore: access_accessregistrationsignup

# - explore: access_accessregistrationsignupfaxverification

# - explore: access_emailverificationcode

# - explore: access_leadgenresponse

# - explore: access_unauthenticatedaccessregistrationlinkuser

# - explore: accounting_customeraccount

# - explore: accounting_customeraccountcredit

# - explore: accounting_customeraccountservice

# - explore: analytics_canonicalphysiciansalesinfoattribute

# - explore: analytics_canonicalphysiciansalesinfokey

# - explore: analytics_canonicalphysiciansummary

# - explore: analytics_clinicalqualitymeasure

# - explore: analytics_clinicalqualitymeasure_value_sets

# - explore: analytics_clinicalqualitymeasurestratification

# - explore: analytics_cmsphysician

# - explore: analytics_codesystem

# - explore: analytics_cqmstatusreason

# - explore: analytics_decisionsupport

# - explore: analytics_decisionsupport_measures

# - explore: analytics_decisionsupportresponseoption

# - explore: analytics_decisionsupportresultingaction

# - explore: analytics_deferrablenotification

# - explore: analytics_deferrableusernotification

# - explore: analytics_letterhttprequestlog

# - explore: analytics_nqfcodedvalue

# - explore: analytics_nqfvalueset

# - explore: analytics_nqfvalueset_coded_values

# - explore: analytics_patientcqmstatus

# - explore: analytics_patientcqmstatusbloodpressurevalue

# - explore: analytics_patientcqmstatusfloatvalue

# - explore: analytics_patientcqmstatusicd10codes

# - explore: analytics_patientcqmstatusintegervalue

# - explore: analytics_patientcqmstatusnqfcodedvaluevalue

# - explore: analytics_patientcqmstatusreason

# - explore: analytics_patientlettersummary

# - explore: analytics_patientprofile

# - explore: analytics_physicianaffiliation

# - explore: analytics_physicianmumanualmeasure

# - explore: analytics_physicianmustatsrollup

# - explore: analytics_physiciannetworknode

# - explore: analytics_physiciannetworkrelationship

# - explore: analytics_physicianstatsdaily

# - explore: analytics_practicesalesinfo

# - explore: analytics_practicestatsdaily

# - explore: analytics_practicesummary

# - explore: analytics_providerletterconversionsummary

# - explore: analytics_providerletterrecipientprofile

# - explore: analytics_providerlettersummary

# - explore: analytics_qualitymeasuregroup

# - explore: analytics_qualitymeasuregroupallowedperiod

# - explore: analytics_qualitymeasuregroupcategory

# - explore: analytics_qualitymeasuregroupcategory_measures

# - explore: analytics_qualitymeasuregrouptoenterprise

# - explore: analytics_qualitymeasuregrouptopractice

# - explore: analytics_referralordersummary

# - explore: analytics_rxreportohprintrecord

# - explore: analytics_survey

# - explore: analytics_surveyanswer

# - explore: analytics_surveyquestion

# - explore: analytics_userfreeformanswer

# - explore: analytics_usersurveyanswer

# - explore: analytics_usersurveyresult

# - explore: api_apivendor

# - explore: api_apivendorenterpriseauthorization

# - explore: api_apivendorpracticeauthorization

# - explore: api_appointmentvendoridentifier

# - explore: api_billvendoridentifier

# - explore: api_patientinsuranceidentifier

# - explore: api_patientvendoridentifier

# - explore: api_physicianuservendoridentifier

# - explore: api_servicelocationvendoridentifier

# - explore: api_surescriptstxincoming

# - explore: api_surescriptstxoutgoing

# - explore: api_surescriptstxoutgoing_bak

# - explore: api_surescriptstxoutgoing_eligibilities

# - explore: auditlogging_actionlog

# - explore: auditlogging_auditedchange

# - explore: auditlogging_elationstaffaccesslog

# - explore: auditlogging_errorlog

# - explore: auditlogging_httprequestlog

# - explore: auditlogging_httprequestlogdetail

# - explore: auditlogging_passportauditlog

# - explore: auditlogging_patientlistquerylog

# - explore: auditlogging_revision

# - explore: auditlogging_sessionlog

# - explore: auth_group

# - explore: auth_group_permissions

# - explore: auth_message

# - explore: auth_permission

# - explore: auth_user

# - explore: auth_user_groups

# - explore: auth_user_user_permissions

# - explore: celery_taskmeta

# - explore: celery_tasksetmeta

# - explore: communication_emaildocument

# - explore: communication_incomingdirectmessage

# - explore: communication_incomingemail

# - explore: communication_incomingemailcontent

# - explore: communication_incomingemailrecipient

# - explore: communication_log

# - explore: communication_outgoingdirectmessage

# - explore: communication_outgoingemail

# - explore: communication_outgoingemailattachment

# - explore: communication_outgoingfax

# - explore: communication_outgoingfaxdetail

# - explore: communication_outgoingfaxnumber

# - explore: communication_sms

# - explore: communication_smsconversation

# - explore: communication_telephonyconversation

# - explore: communication_userdirectaddress

# - explore: data_export_ccdaexport

# - explore: data_export_documentexport

# - explore: data_export_exportfile

# - explore: data_export_exportrequest

# - explore: data_export_patientexport

# - explore: data_export_profileexport

# - explore: data_import_addpracticetoenterpriselog

# - explore: data_import_bulkxmlpatientsummaryimport

# - explore: data_import_bulkxmlpatientsummaryimport_xml_patient_summaries

# - explore: data_import_dataimportrequest

# - explore: data_import_patientchartimport

# - explore: data_import_patientdemogimportrequest

# - explore: data_import_practicefusionconstants

# - explore: data_import_remotedocumentidentity

# - explore: data_import_remotepracticeidentity

# - explore: data_import_remoteuseridentity

# - explore: data_import_renderingrequest

# - explore: data_import_renderingresult

# - explore: data_import_xmlpatientsummary

# - explore: delete_notes_vnitemplate

# - explore: deleted_meds_patientmed

# - explore: deleted_meds_patientmedslist

# - explore: deleted_meds_patientmedslisttopatientmed

# - explore: deleted_notes_patientpedetail

# - explore: deleted_notes_patientrosdetail

# - explore: deleted_notes_visitnotecpt

# - explore: deleted_notes_visitnotedx

# - explore: deleted_notes_visitnoteitem

# - explore: deleted_notes_vniassessment

# - explore: deleted_notes_vnidata

# - explore: deleted_notes_vnidatadocument

# - explore: deleted_notes_vnidatalabreport

# - explore: deleted_notes_vnimed

# - explore: deleted_notes_vniproblem

# - explore: deleted_notes_vniproblemhpi

# - explore: deleted_notes_vnitest

# - explore: deleted_notes_vnitx

# - explore: deleted_patientmeddocument

# - explore: deleted_shareable_medicalproblem

# - explore: django_admin_log

# - explore: django_content_type

# - explore: django_session

# - explore: django_site

# - explore: djcelery_crontabschedule

# - explore: djcelery_intervalschedule

# - explore: djcelery_periodictask

# - explore: djcelery_periodictasks

# - explore: djcelery_taskstate

# - explore: djcelery_workerstate

# - explore: entities_enterprise

# - explore: entities_entity

# - explore: entities_externalapiuserprofile

# - explore: entities_externalapiusertopractice

# - explore: entities_loginlockout

# - explore: entities_pbm

# - explore: entities_physician_deleted

# - explore: entities_practice

# - explore: entities_practiceagreement

# - explore: entities_practiceagreementsignature

# - explore: entities_practicefax

# - explore: entities_practiceidentifier

# - explore: entities_practiceprintheader

# - explore: entities_practiceregistryidentifiers

# - explore: entities_practicesettings

# - explore: entities_practicesettings_staff_cds_measures_enabled

# - explore: entities_servicelocation

# - explore: entities_testaccountdetails

# - explore: entities_userloginattempt

# - explore: entities_userprofile

# - explore: features_enterprisefeature

# - explore: features_featuredefault

# - explore: features_ftuestatus

# - explore: features_practiceemrtypefeature

# - explore: features_practicefeature

# - explore: features_userfeature

# - explore: filemgr_availablehandouttag

# - explore: filemgr_documentfile

# - explore: filemgr_documentimage

# - explore: filemgr_emaildocumentfile

# - explore: filemgr_handout

# - explore: filemgr_handout_tags

# - explore: filemgr_importedfile

# - explore: filemgr_patientphoto

# - explore: filemgr_unprocessedincomingfile

# - explore: filemgr_uploadedfile

# - explore: filemgr_uploadedfilelock

# - explore: filemgr_uploadedimage

# - explore: filemgr_uploadedphoto

# - explore: filemgr_userphoto

# - explore: formulary_benefitcopaylist

# - explore: formulary_benefitcopaylistdrugspecificrow

# - explore: formulary_benefitcopaylistsummarylevelrow

# - explore: formulary_benefitcoveragelist

# - explore: formulary_benefitcoveragelistagelimitsrow

# - explore: formulary_benefitcoveragelistgenderlimitsrow

# - explore: formulary_benefitcoveragelistmedicalnecessityrow

# - explore: formulary_benefitcoveragelistpriorauthorizationrow

# - explore: formulary_benefitcoveragelistproductcoverageexclusionrow

# - explore: formulary_benefitcoveragelistquantitylimitsrow

# - explore: formulary_benefitcoveragelistresourcelinkdrugspecificrow

# - explore: formulary_benefitcoveragelistresourcelinksummarylevelrow

# - explore: formulary_benefitcoverageliststepmedicationsrow

# - explore: formulary_benefitcoverageliststeptherapyrow

# - explore: formulary_benefitcoveragelisttextmessagerow

# - explore: formulary_formularyalternativeslist

# - explore: formulary_formularyalternativeslistrow

# - explore: formulary_formularybenefitfile

# - explore: formulary_formularycoverageid

# - explore: formulary_formularyndc

# - explore: formulary_formularyrxnorm

# - explore: formulary_formularystatuslist

# - explore: formulary_formularystatuslistrow

# - explore: formulary_sspharmacy

# - explore: formulary_ssprescriber

# - explore: internal_tool_internalmessage

# - explore: internal_tool_internalmessageattachment

# - explore: internal_tool_internalmessagerecipient

# - explore: internal_tool_remotefile

# - explore: internal_tool_remotefolder

# - explore: internal_tool_remoteuser

# - explore: labs_care360observationresultrequest

# - explore: labs_care360provideraccount

# - explore: labs_labintegratoractivitylog

# - explore: labs_labintegratorvendor

# - explore: labs_labordercontent_tests_old

# - explore: labs_labordertest_old

# - explore: letters_letter

# - explore: letters_letterattachment

# - explore: letters_lettercategory

# - explore: letters_letterreceipt

# - explore: letters_letterreceiptattachment

# - explore: letters_letterroutingrule

# - explore: letters_letterroutingrule_staffgroups

# - explore: letters_letterroutingrule_users

# - explore: letters_lettertemplate

# - explore: letters_unreadletternotification

# - explore: meds_coverage

# - explore: meds_denialmedorder

# - explore: meds_discontinuemedorder

# - explore: meds_eligibility

# - explore: meds_eligibility_coverages

# - explore: meds_medorder

# - explore: meds_medorderdruginteraction

# - explore: meds_medorderfill

# - explore: meds_medorderfulfillment

# - explore: meds_medorderinteraction

# - explore: meds_medorderthread

# - explore: meds_physicianmedicationmetadata

# - explore: meds_rxhistorydownload

# - explore: meds_rxhistorydownloadmedorder

# - explore: meds_rxhistorydownloadmedorderfill

# - explore: meds_rxhistorydownloadmedorderthread

# - explore: meds_rxhistorydownloadsummary

# - explore: meds_rxitem

# - explore: meds_rxitem_diagnoses

# - explore: meds_rxitem_refills

# - explore: meds_rxitemdiagnosis

# - explore: meds_rxitemprescriber

# - explore: meds_rxitemrefill

# - explore: meds_rxrefillmedication

# - explore: meds_rxrefillmedication_diagnoses

# - explore: meds_rxrefillrequest

# - explore: meds_rxrefillrequestdiagnosis

# - explore: meds_rxrefillrequestpatient

# - explore: meds_rxrefillrequestpatientphone

# - explore: meds_rxrefillrequestpharmacy

# - explore: meds_rxrefillrequestpharmacyphone

# - explore: meds_rxrefillrequestprescriber

# - explore: meds_rxrefillrequestprescriberphone

# - explore: meds_rxrefillrequestraw

# - explore: meds_rxrefillrequestsupervisor

# - explore: meds_rxrefillrequestsupervisorphone

# - explore: meds_rxrefillresponse

# - explore: messaging_comment

# - explore: messaging_messagethread

# - explore: messaging_premademessage

# - explore: messaging_threadmember

# - explore: messaging_threadmessage

# - explore: notes_amendmentrequest

# - explore: notes_appointmenttypevisitnotesettings

# - explore: notes_bill

# - explore: notes_billcpt

# - explore: notes_billcptdx

# - explore: notes_billcptdxtoicd9

# - explore: notes_billingreportcsvexport

# - explore: notes_billreferringprovider

# - explore: notes_checklisttemplate

# - explore: notes_checklisttemplatefield

# - explore: notes_checkout

# - explore: notes_customobservation

# - explore: notes_customobservationresult

# - explore: notes_nonvisitnote

# - explore: notes_nonvisitnotebullet

# - explore: notes_nonvisitnotedocument

# - explore: notes_nonvisitnotepatientitem

# - explore: notes_nonvisitnotetype

# - explore: notes_notesettings

# - explore: notes_patientpayment

# - explore: notes_visitnote

# - explore: notes_visitnote_extra_codes

# - explore: notes_visitnote_extra_icd9

# - explore: notes_visitnotealert

# - explore: notes_visitnotebullet

# - explore: notes_visitnotebullet_imo_codes

# - explore: notes_visitnotechecklist

# - explore: notes_visitnotechecklistfield

# - explore: notes_visitnotedocument

# - explore: notes_visitnoteedit

# - explore: notes_visitnotepatientitem

# - explore: notes_visitnotesummary

# - explore: notes_visitnotetype

# - explore: notes_vitalscollection

# - explore: notes_vnibp

# - explore: notes_vnihc

# - explore: notes_vniheight

# - explore: notes_vnihr

# - explore: notes_vnioxygen

# - explore: notes_vnipain

# - explore: notes_vnirr

# - explore: notes_vnitemperature

# - explore: notes_vniweight

# - explore: orders_cardiacorder

# - explore: orders_cardiacorder_ccs

# - explore: orders_cardiacordercontent

# - explore: orders_cardiacordercontent_icd10_codes

# - explore: orders_cardiacordercontent_icd9_codes

# - explore: orders_cardiacordercontent_tests

# - explore: orders_cardiacordercontent_tests_old

# - explore: orders_cardiacordertest_old

# - explore: orders_imagingorder

# - explore: orders_imagingorder_ccs

# - explore: orders_imagingordercontent

# - explore: orders_imagingordercontent_icd10_codes

# - explore: orders_imagingordercontent_icd9_codes

# - explore: orders_imagingordercontent_tests

# - explore: orders_imagingordercontent_tests_old

# - explore: orders_imagingordertest_old

# - explore: orders_laborder

# - explore: orders_laborder_ccs

# - explore: orders_labordercontent

# - explore: orders_labordercontent_icd10_codes

# - explore: orders_labordercontent_icd9_codes

# - explore: orders_labordercontent_tests

# - explore: orders_laborderset

# - explore: orders_labordersubmission

# - explore: orders_pulmonaryorder

# - explore: orders_pulmonaryorder_ccs

# - explore: orders_pulmonaryordercontent

# - explore: orders_pulmonaryordercontent_icd10_codes

# - explore: orders_pulmonaryordercontent_icd9_codes

# - explore: orders_pulmonaryordercontent_tests

# - explore: orders_pulmonaryordercontent_tests_old

# - explore: orders_pulmonaryordertest_old

# - explore: orders_referralorder

# - explore: orders_referralorder_icd10_codes

# - explore: orders_referralorder_icd9_codes

# - explore: orders_sleeporder

# - explore: orders_sleeporder_ccs

# - explore: orders_sleepordercontent

# - explore: orders_sleepordercontent_icd10_codes

# - explore: orders_sleepordercontent_icd9_codes

# - explore: orders_sleepordercontent_tests

# - explore: orders_sleepordercontent_tests_old

# - explore: orders_sleepordertest_old

# - explore: passport_passportfaxout

# - explore: patients_availablepatienttag

# - explore: patients_chartfeedreview

# - explore: patients_chartmergelog

# - explore: patients_chartmergelogitem

# - explore: patients_clinicalprofilereview

# - explore: patients_codeddocumenttag

# - explore: patients_confidentialityrecord

# - explore: patients_doctype_backup

# - explore: patients_document_doc_tags

# - explore: patients_documentaddendum

# - explore: patients_documentgrant

# - explore: patients_documentrequiringaction

# - explore: patients_documentsource

# - explore: patients_eligiblepatient

# - explore: patients_internalpracticenote

# - explore: patients_masterpatient

# - explore: patients_meaningfuluseinfo

# - explore: patients_oldpatientchartimport

# - explore: patients_patient

# - explore: patients_patientaddress

# - explore: patients_patientalias

# - explore: patients_patientbillingdetails

# - explore: patients_patientcollaboratornotification

# - explore: patients_patientdesignate

# - explore: patients_patientemail

# - explore: patients_patientfileimport

# - explore: patients_patientimport

# - explore: patients_patientimport_patients

# - explore: patients_patientimportresult

# - explore: patients_patientinsurance

# - explore: patients_patientinsuranceguarantor

# - explore: patients_patientitem

# - explore: patients_patientnextofkin

# - explore: patients_patientphone

# - explore: patients_patientproviderteam

# - explore: patients_patientproviderteammember

# - explore: patients_patientproviderteammemberactivity

# - explore: patients_patienttag

# - explore: patients_practicepatientpreferences

# - explore: patients_practicepatientpreferences_broken

# - explore: patients_practicetopatient

# - explore: patients_vendorpatientidentifier

# - explore: practicians_availablecds

# - explore: practicians_canonicalfieldoverride

# - explore: practicians_canonicaloverridelog

# - explore: practicians_canonicalphysician

# - explore: practicians_canonicalphysician_other_specialties

# - explore: practicians_canonicalphysiciansalesinfo

# - explore: practicians_cdssettinglog

# - explore: practicians_defaultsharingsettings

# - explore: practicians_delegatepermission

# - explore: practicians_esignature

# - explore: practicians_eulaupdateacknowledgment

# - explore: practicians_officestaff

# - explore: practicians_onboardingevent

# - explore: practicians_physician

# - explore: practicians_physician_other_specialties

# - explore: practicians_physicianaccount

# - explore: practicians_physiciancredentialdocument

# - explore: practicians_physicianidentifier

# - explore: practicians_physicianidplog

# - explore: practicians_physicianinvitation

# - explore: practicians_physicianinvitationresponse

# - explore: practicians_physicianonboardinglabinterfacesetup

# - explore: practicians_physicianonboardinglabinterfacesetuptask

# - explore: practicians_physicianonboardingsurvey

# - explore: practicians_physicianonboardingsurveyitem

# - explore: practicians_physicianonboardingtask

# - explore: practicians_physicianonboardingtrainingsession

# - explore: practicians_physicianonboardingtrainingsession_participants

# - explore: practicians_physicianpracticeidentifier

# - explore: practicians_physicianrequestedlab

# - explore: practicians_practicetophysician

# - explore: practicians_practicetostaff

# - explore: practicians_staffgroup

# - explore: practicians_staffgroup_users

# - explore: practicians_supervisedrxauthority

# - explore: practicians_userpreferences

# - explore: practicians_userpreferences_cds_measures_enabled

# - explore: reference_confidentialitem

# - explore: reference_patientallergy

# - explore: reference_patientallergy_archive

# - explore: reference_patientallergydocumentation

# - explore: reference_patientcdaimport

# - explore: reference_patientdrugintolerance

# - explore: reference_patientdrugintolerancedocumentation

# - explore: reference_patientfamilyhistoryitem

# - explore: reference_patientfamilyrelationship

# - explore: reference_patienthistoryitem

# - explore: reference_patienthistoryitem_archive

# - explore: reference_patienthistoryitemphysician

# - explore: reference_patientimmunization

# - explore: reference_patientimmunizationdecline

# - explore: reference_patientproblem

# - explore: reference_patientproblem_icd9_codes

# - explore: reference_patientproblem_imo_codes

# - explore: reference_patientproblem_snomed_codes

# - explore: reference_patientproblemdocumentation

# - explore: reference_patientproblemxwalknotifier

# - explore: reference_patientsmokingstatus

# - explore: reference_practicevaccinepreferences

# - explore: registration_invite

# - explore: registration_patientinvite

# - explore: registration_physicianinvite

# - explore: registration_prospectuser

# - explore: registration_prospectusersignup

# - explore: registration_providersecuritycode

# - explore: registration_referralemail

# - explore: registration_registrationprofile

# - explore: registration_staffinvite

# - explore: reports_historicallabsimport

# - explore: reports_inboundreporthl7

# - explore: reports_inboundreporthl7_reports

# - explore: reports_inboundreporthl7_unassigned_reports

# - explore: reports_inboundreportmessage

# - explore: reports_inboundreportserver

# - explore: reports_labresult

# - explore: reports_labresultgrid

# - explore: reports_practicereporttype

# - explore: reports_rawreport

# - explore: reports_rawreportcommonorder

# - explore: reports_rawreportobservation

# - explore: reports_rawreportobservationnote

# - explore: reports_rawreportobservationrequest

# - explore: reports_rawreportobservationspecimen

# - explore: reports_report

# - explore: reports_report_archive

# - explore: reports_reportnoteitem

# - explore: reports_reportnoteitem_archive

# - explore: reports_reportnotetemplate

# - explore: reports_reporttotag

# - explore: reports_unassignedlabreport

# - explore: reports_unassignedlabreportimport

# - explore: reports_unassignedlabreportimport_unassigned_reports

# - explore: reports_unassignedlabresultgrid

# - explore: sandbox_campaigncode

# - explore: sandbox_potentiallead

# - explore: sandbox_practicesandbox

# - explore: sandbox_sandboximage

# - explore: sandbox_sandboxusermessage

# - explore: sandbox_sandboxusermessagerecipient

# - explore: scheduler_appointment

# - explore: scheduler_appointmentbillingdetails

# - explore: scheduler_appointmentreminder

# - explore: scheduler_appointmentroom

# - explore: scheduler_appointmentstatus

# - explore: scheduler_appointmenttype

# - explore: scheduler_recurringeventgroup

# - explore: scheduler_recurringeventschedule

# - explore: security_challengequestion

# - explore: security_challengequestionanswer

# - explore: shareable_allergy

# - explore: shareable_ancillarycompany

# - explore: shareable_assortedcode

# - explore: shareable_availabledocumenttag

# - explore: shareable_cardiaccenter

# - explore: shareable_cardiacordertest

# - explore: shareable_cardiacordertestcategory

# - explore: shareable_condition

# - explore: shareable_cptcode

# - explore: shareable_directions

# - explore: shareable_hcccategory

# - explore: shareable_hccdemographics

# - explore: shareable_hccdisabilityinteraction

# - explore: shareable_hccdiseaseinteraction

# - explore: shareable_hccinteractiongroup

# - explore: shareable_hccinteractiongroup_hcc_categories

# - explore: shareable_hccmedicaiddisabilitystatus

# - explore: shareable_hccoriginallydisabledstatus

# - explore: shareable_healthcheck

# - explore: shareable_hospital

# - explore: shareable_icd10code

# - explore: shareable_icd10code_hcc_categories

# - explore: shareable_icd9code

# - explore: shareable_icd9code_conditions

# - explore: shareable_icd9code_snomeds

# - explore: shareable_icd9codeset

# - explore: shareable_icd9codeset_diagnoses

# - explore: shareable_imagingcenter

# - explore: shareable_imagingordertest

# - explore: shareable_imagingordertestcategory

# - explore: shareable_immunization

# - explore: shareable_imocode

# - explore: shareable_imocodetoicd10

# - explore: shareable_imocodetoicd9

# - explore: shareable_insurancecompany

# - explore: shareable_insuranceplan

# - explore: shareable_labcenter

# - explore: shareable_labordertest

# - explore: shareable_labtest

# - explore: shareable_labtest_categories

# - explore: shareable_labtestcategory

# - explore: shareable_labtestcenter

# - explore: shareable_labtestgroup

# - explore: shareable_labtestgroup_lab_tests

# - explore: shareable_labtestgroup_problem_icd9s

# - explore: shareable_labtestpreferences

# - explore: shareable_labtestunits

# - explore: shareable_labvendor

# - explore: shareable_language

# - explore: shareable_loinccode

# - explore: shareable_medicalspecialty

# - explore: shareable_medicalspecialtycategory

# - explore: shareable_medication

# - explore: shareable_medication_archive

# - explore: shareable_medication_deleted

# - explore: shareable_medication_rxnorms

# - explore: shareable_medispanmedicationupdate

# - explore: shareable_mvxcode

# - explore: shareable_othercontact

# - explore: shareable_packagedmedication

# - explore: shareable_packagedmedicationlabeler

# - explore: shareable_practiceancillarypreferences

# - explore: shareable_practicesupportmessage

# - explore: shareable_pulmonarycenter

# - explore: shareable_pulmonaryordertest

# - explore: shareable_pulmonaryordertestcategory

# - explore: shareable_rxnorm

# - explore: shareable_rxsig

# - explore: shareable_serverstatus

# - explore: shareable_sleepcenter

# - explore: shareable_sleepordertest

# - explore: shareable_sleepordertestcategory

# - explore: shareable_snomedcode

# - explore: shareable_supportmessage

# - explore: shareable_supportmessageassignment

# - explore: shareable_userfeedback

# - explore: shareable_usersupportmessage

# - explore: shareable_vaccine

# - explore: shareable_vaccinepackagedmedication

# - explore: shareable_vaccinepackagedmedicationdose

# - explore: south_migrationhistory

# - explore: stats_practicedata

# - explore: stats_practicestat

# - explore: stats_searchevent

# - explore: stats_systemstat

# - explore: stats_userdata

# - explore: stats_userstat

# - explore: tickler_tickle

# - explore: tickler_tickle_archive

# - explore: uimetrics_actiontype

# - explore: uimetrics_actiontypeassignment

# - explore: uimetrics_ajaxrequest

# - explore: uimetrics_bracketableaction

# - explore: uimetrics_contextchange

# - explore: uimetrics_element

# - explore: uimetrics_elementassignment

# - explore: uimetrics_group

# - explore: uimetrics_pagesession

# - explore: uimetrics_timedevent

# - explore: uimetrics_useraction

