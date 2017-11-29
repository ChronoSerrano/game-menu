$(document).ready ->
  $ ->
    $.extend $.tablesorter.defaults,
      widgets: [
        "zebra"
        "filter"
      ]

    $("#myTable").tablesorter()

    return
