locals {
  //Page 1
  page1 = {
    name            = "External SLO",
    widget_markdown = [local.widget_markdown1_page1]
    widget_billboard = [
      local.widget_billboard1_page1,
      local.widget_billboard2_page1,
      local.widget_billboard3_page1,
      local.widget_billboard4_page1,
      local.widget_billboard5_page1,
      local.widget_billboard6_page1,
      local.widget_billboard7_page1,
      local.widget_billboard8_page1
    ]
    widget_pie   = [local.widget_pie1_page1]
    widget_bar   = [local.widget_bar1_page1]
    widget_table = [local.widget_table1_page1]
    widget_line  = [
      local.widget_line1_page1, 
      local.widget_line2_page1,
      local.widget_line3_page1
    ]
  }


  //Widget markdown in  page1
  widget_markdown1_page1 = {
    title  = "Newsletter SLO"
    row    = 1
    column = 1
    text   = "# Newsletter Internal SLO"
    width  = 12
    height = 1

  }

  widget_billboard1_page1 = {
    title  = "Global Requests per Minute"
    row    = 2
    column = 1
    width  = 4
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT rate(count(*), 1 minute ) WHERE appName = 'Newsletter'"
    }
  }

  widget_billboard2_page1 = {
    title  = "Total Transactions Served"
    row    = 2
    column = 5
    width  = 4
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT count(*) WHERE appName = 'Newsletter' AND transactionType = 'Web'"
    }
  }

  widget_pie1_page1 = {
    title  = "Error Code Percentages"
    row    = 2
    column = 9
    width  = 4
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT count(*) FACET httpResponseCode WHERE appName = 'Newsletter'"
    }
  }
  widget_bar1_page1 = {
    title  = "RPM per URI"
    row    = 5
    column = 1
    width  = 4
    height = 4
    nrql_query = {
      account_id = "3366273"
      query      = "SELECT rate(count(*), 1 minute ) FROM Transaction FACET `request.uri` WHERE appName = 'Newsletter' LIMIT MAX "
    }
  }

  widget_table1_page1 = {
    title  = "Latencies per URI (ms)"
    row    = 5
    column = 5
    width  = 8
    height = 4
    nrql_query = {
      account_id = "3366273"
      query      = "SELECT median(duration) * 1000 as Median, average(duration) * 1000 as Average , percentile(duration, 95) * 1000, percentile(duration, 99) * 1000 FROM Transaction FACET `request.uri` WHERE (appName = 'Newsletter') AND (transactionType = 'Web') LIMIT MAX"
    }
  }
  widget_billboard3_page1 = {
    title  = "[P99] /subscribe (ms)"
    row    = 9
    column = 1
    width  = 3
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/subscribe')"
    }
  }

  widget_billboard4_page1 = {
    title  = "[Percentage] /subscribe"
    row    = 9
    column = 4
    width  = 4
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 100 * filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/subscribe') AND (request.method = 'POST') AND (1000 * duration) < 200) / filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/subscribe') AND (request.method = 'POST')) AS '% of Requests < 200 ms'"
    }
  }

  widget_line1_page1 = {
    title  = "[p99 Chart] /subscribe (ms)"
    row    = 9
    column = 8
    width  = 5
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/subscribe') TIMESERIES AUTO"
    }
  }

  widget_billboard5_page1 = {
    title  = "[P99] /unsubscribe (ms)"
    row    = 11
    column = 1
    width  = 3
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/unsubscribe') AND (request.method = 'POST')"
    }
  }

  widget_billboard6_page1 = {
    title  = "[Percentage] /unsubscribe"
    row    = 9
    column = 4
    width  = 4
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 100 * filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/unsubscribe') AND (request.method = 'POST') AND (1000 * duration) < 200) / filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/unsubscribe') AND (request.method = 'POST')) AS '% of Requests < 200 ms'"
    }
  }

  widget_line2_page1 = {
    title  = "[p99 Chart] /unsubscribe (ms)"
    row    = 9
    column = 8
    width  = 5
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/unsubscribe') TIMESERIES AUTO"
    }
  }

  widget_billboard7_page1 = {
    title  = "[P99] GET / (ms)"
    row    = 11
    column = 1
    width  = 3
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/') AND (request.method = 'GET')"
    }
  }

  widget_billboard8_page1 = {
    title  = "[Percentage] GET /"
    row    = 9
    column = 4
    width  = 4
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 100 * filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/') AND (request.method = 'GET') AND (1000 * duration) < 200) / filter(count(*), WHERE (appName = 'Newsletter') AND (request.uri = '/') AND (request.method = 'GET')) AS '% of Requests < 200 ms'"
    }
  }

  widget_line3_page1 = {
    title  = "[p99 Chart] GET / (ms)"
    row    = 9
    column = 8
    width  = 5
    height = 2
    nrql_query = {
      account_id = "3366273"
      query      = "FROM Transaction SELECT 1000 * percentile(duration ,99) AS 'p99 Latency (ms)' WHERE (appName = 'Newsletter') AND (request.uri = '/') AND (request.method = 'GET') TIMESERIES AUTO"
    }
  }

}