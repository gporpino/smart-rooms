# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  visualSearch = VS.init(
    container: $(".visual_search")
    query: ""
    callbacks:
      search: (query, searchCollection) ->
        alert searchCollection.serialize()
        $.getJSON "/smart_reservations/query.json?q=" + searchCollection.serialize(), (data) ->
          callback data

      facetMatches: (callback) ->
        $.getJSON "/smart_reservations/facets.json", (data) ->
          callback data

      valueMatches: (facet, searchTerm, callback) ->
        $.getJSON "/smart_reservations/values/" + facet + ".json", (data) ->
          callback data
  )