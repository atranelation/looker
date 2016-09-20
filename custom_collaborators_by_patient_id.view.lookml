- view: custom_collaborators_by_patient_id
  derived_table:
    sql: |
        SELECT practicetopatient.patient_id, COUNT(*) AS NumberOfCollaborators
          FROM patients_patientproviderteammember patientproviderteammember
            JOIN patients_patientproviderteam patientproviderteam ON patientproviderteam.id = patientproviderteammember.team_id  AND patientproviderteammember.deleteLog_id IS NOT NULL
            JOIN patients_practicetopatient practicetopatient ON practicetopatient.id = patientproviderteam.practice_to_patient_id
          GROUP BY patient_id 

  fields:
    - dimension: patient_id
      type: number
      primary_key: true
      sql: ${TABLE}.patient_id

    - dimension: NumberOfCollaborators
      type: number
      sql: ${TABLE}.NumberOfCollaborators

    - measure: chart_count
      type: count
