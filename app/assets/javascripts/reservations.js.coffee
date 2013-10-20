# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $(".datetimepicker").datetimepicker
    pickSeconds: false
  $("#reservation_initial_date").unwrap() if $("#reservation_initial_date").parent().hasClass('field_with_errors')
  $("#reservation_end_date").unwrap() if $("#reservation_end_date").parent().hasClass('field_with_errors')
  events_array = []
  if $("#calendar").length > 0
    $.getJSON("/reservations/"+$('#calendar').data('room'), (data) ->
      $.each data, (index, value) ->
        events_array.push
          startDate: new Date(value.startDate)
          endDate: new Date(value.endDate)
          title: value.title
          description: value.description
          priority: value.priority
          frecuency: value.frecuency
    ).done ->
      $("#calendar").dp_calendar
        events_array: events_array
        order_by: 1
        show_datepicker: false
$(document).ready(ready)
$(document).on('page:load', ready)
