connection: "demo_ecommerce"

# include all the views
include: "/views/**/*.view"

datagroup: mmb_demo_ecommerce_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: mmb_demo_ecommerce_default_datagroup

explore: order_items {

  ####################### SEGMENTAZIONE #########################

  #access_filter: {
  #  field: users.country
  #  user_attribute: country_filter
  #}

  ###############################################################

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: events {
    type: left_outer
    sql_on: ${users.id} = ${events.user_id} ;;
    relationship: one_to_many
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${order_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.order_id} ;;
    relationship: many_to_one
  }

  join: distribution_centers {
    type: left_outer
    sql_on: ${products.distribution_center_id} = ${distribution_centers.id} ;;
    relationship: many_to_one
  }

  ################################################# SEGMENTAZIONE PER GRUPPI ######################################################

  sql_always_where: ${users.country} in ("{{ _user_attributes['colombia_filter'] }}", "{{ _user_attributes['australia_filter'] }}") ;;

  #################################################################################################################################

}
