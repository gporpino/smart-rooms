# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $(".datetimepicker").datetimepicker
    language: 'pt-BR'
    pickSeconds: false
  $("#reservation_initial_date").unwrap() if $("#reservation_initial_date").parent().hasClass('field_with_errors')
  $("#reservation_end_date").unwrap() if $("#reservation_end_date").parent().hasClass('field_with_errors')

$(document).ready(ready)
$(document).on('page:load', ready)
