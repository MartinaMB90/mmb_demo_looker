view: period_over_period {
  extension: required

  filter: date_comparison_filter {
    view_label: "Date Comparison"
    description: "This filter refers to the order creation date"
    type: date
    suggest_dimension: orders.created_raw
  }

  dimension: ytd_vs_lytd {
    hidden: yes
    view_label: "Date Comparison"
    type: string
    sql: CASE
          WHEN ${orders.created_raw} >= {% date_start date_comparison_filter %} and ${orders.created_raw} < {% date_end date_comparison_filter %} THEN 'This YTD'
          WHEN date(${orders.created_raw}) >= DATE_SUB(date({% date_start date_comparison_filter %}), INTERVAL 1 YEAR) and date(${orders.created_raw}) < DATE_SUB(date({% date_end date_comparison_filter %}), INTERVAL 1 YEAR) THEN 'Prior YTD'
         END;;
  }

}
