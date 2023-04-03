include: "period_over_period.view.lkml"
view: orders {
  sql_table_name: `thelook_ecommerce.orders`
    ;;
  extends: [period_over_period]

  dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
    html: {% if value == 'F' %}
    <p style="color: white; background-color: pink; margin: 0; border-radius: 5px; text-align:center">{{ rendered_value }}</p>
    {% else %}
    <p style="color: white; background-color: blue; margin: 0; border-radius: 5px; text-align:center">{{ rendered_value }}</p>
    {% endif %};;
  }

  dimension: num_of_item {
    type: number
    sql: ${TABLE}.num_of_item ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: orders_count_ac {
    label: "Num. ordini"
    type: count_distinct
    sql: ${order_id} ;;
    value_format: "#,##0"
    filters: [ytd_vs_lytd: "This YTD"]
  }

  measure: num_ordini2 {
    type: number
    sql: ${orders_count_ac} * 2 ;;
  }

  measure: orders_count_ap {
    label: "Num. ordini AP"
    type: count_distinct
    sql: ${order_id} ;;
    filters: [ytd_vs_lytd: "Prior YTD"]
    drill_fields: [order_id, users.last_name, users.id, users.first_name, order_items.count]
  }
}
