locals {
  //Pages
  pages = [local.page1]
}

resource "newrelic_one_dashboard" "newsletter_dashboard" {
  name = "Dashboard Staging"
  dynamic "page" {
    for_each = local.pages
    content {
      name = page.value.name
      dynamic "widget_markdown" {
        for_each = page.value.widget_markdown
        content {
          title  = widget_markdown.value.title
          row    = widget_markdown.value.row
          column = widget_markdown.value.column
          width  = widget_markdown.value.width
          height = widget_markdown.value.height
          text   = widget_markdown.value.text
        }
      }
      dynamic "widget_billboard" {
        for_each = page.value.widget_billboard
        content {
          title  = widget_billboard.value.title
          row    = widget_billboard.value.row
          column = widget_billboard.value.column
          width  = lookup(widget_billboard.value, "width", 4)
          height = lookup(widget_billboard.value, "height", 3)
          nrql_query {
            account_id = widget_billboard.value.nrql_query.account_id
            query      = widget_billboard.value.nrql_query.query
          }
        }
      }
      dynamic "widget_pie" {
        for_each = page.value.widget_pie
        content {
          title  = widget_pie.value.title
          row    = widget_pie.value.row
          column = widget_pie.value.column
          width  = lookup(widget_pie.value, "width", 4)
          height = lookup(widget_pie.value, "height", 3)
          nrql_query {
            account_id = widget_pie.value.nrql_query.account_id
            query      = widget_pie.value.nrql_query.query
          }
        }
      }
      dynamic "widget_bar" {
        for_each = page.value.widget_bar
        content {
          title  = widget_bar.value.title
          row    = widget_bar.value.row
          column = widget_bar.value.column
          width  = lookup(widget_bar.value, "width", 4)
          height = lookup(widget_bar.value, "height", 3)
          nrql_query {
            account_id = widget_bar.value.nrql_query.account_id
            query      = widget_bar.value.nrql_query.query
          }
        }
      }
      dynamic "widget_table" {
        for_each = page.value.widget_table
        content {
          title  = widget_table.value.title
          row    = widget_table.value.row
          column = widget_table.value.column
          width  = lookup(widget_table.value, "width", 4)
          height = lookup(widget_table.value, "height", 3)
          nrql_query {
            account_id = widget_table.value.nrql_query.account_id
            query      = widget_table.value.nrql_query.query
          }
        }
      }
      dynamic "widget_line" {
        for_each = page.value.widget_line
        content {
          title  = widget_line.value.title
          row    = widget_line.value.row
          column = widget_line.value.column
          width  = lookup(widget_line.value, "width", 4)
          height = lookup(widget_line.value, "height", 3)
          nrql_query {
            account_id = widget_line.value.nrql_query.account_id
            query      = widget_line.value.nrql_query.query
          }
        }
      }
    }
  }
}