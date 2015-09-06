# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".chosen-select").chosen({ width: "100%" })
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 15
  $('#add-dates').click (e) ->
    e.preventDefault()
    date = $('#event_start_at').val()
    time = $('#event_start_at_time').val()
    elem = $('<input>').val(date+" "+time).attr('readonly',true)
    $('#selected-dates').append($('<div>').attr('class', 'row'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'selected-date col s8'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'col s2'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'col s2'))
    $('#selected-dates .selected-date:last').append(elem)