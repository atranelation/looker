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

    
    


# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# - explore: order_items
#   joins:
#     - join: orders
#       sql_on: ${orders.id} = ${order_items.order_id}
#     - join: users
#       sql_on: ${users.id} = ${orders.user_id}
