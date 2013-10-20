# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
create_reservation_link = (link) ->
  alert link.data("params")
String::format = String::f = ->
  s = this
  i = arguments_.length
  s = s.replace(new RegExp("\\{" + i + "\\}", "gm"), arguments_[i])  while i--
  s

String::replaceAll = (find, replace) ->
  @replace new RegExp(find, "g"), replace

ready = ->
  visualSearch = VS.init(
    container: $(".visual_search")
    query: ""
    callbacks:
      search: (query, searchCollection) ->
        json = {}
        unless query.trim() is ""
          queries = query.split("\" ")
          i = 0
          while i < queries.length
            paramText = queries[i].replaceAll("\"", "")
            params = paramText.split(": ")
            j = $.parseJSON("{ \"{0}\":\"{1}\" }".f(params[0], params[1]))
            $.extend json, j
            i = i + 1
        $.get "/smart_reservations/search", json, (result) ->
          q = JSON.stringify(visualSearch.searchQuery.facets())
          $("#result").html result
          $("#links li a").each (index) ->
            old = @href
            @href = old + "?q=" + q



      facetMatches: (callback) ->
        query = visualSearch.searchBox.currentQuery
        json = []
        unless query.trim() is ""
          queries = query.split("\" ")
          i = 0
          while i < queries.length
            paramText = queries[i].replaceAll("\"", "")
            params = paramText.split(": ")
            j = $.parseJSON("{ \"{0}\":\"{1}\" }".f(params[0], params[1]))
            $.extend json, j
            i = i + 1
        $.getJSON "/smart_reservations/facets.json", json, (data) ->
          callback data


      valueMatches: (facet, searchTerm, callback) ->
        $.getJSON "/smart_reservations/values/" + facet + ".json", (data) ->
          callback data

  )

$(document).ready(ready)
$(document).on('page:load', ready)
