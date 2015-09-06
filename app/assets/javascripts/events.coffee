# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class @Event
  constructor: ->
    @event = {}
    @event.dates = []
  addDate: (datetime) ->
    if @event.dates.length < 3 then @event.dates.push([datetime]) else false
  createDateRow: ->
    $('#selected-dates').append($('<div>').attr('class', 'row'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'selected-date col s8'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'col s2'))
    $('#selected-dates .row:last').append($('<div>').attr('class', 'col s2'))

$ ->
  event = new Event
  $(".chosen-select").chosen({ width: "100%" })
  $('.datepicker').pickadate
    selectMonths: true
    selectYears: 15
  $('#add-dates').click (e) ->
    e.preventDefault()
    date = $('#event_start_at').val()
    time = $('#event_start_at_time').val()
    datetime = date+" "+time
    elem = $('<input>').val(datetime).attr('readonly',true)
    if(event.addDate(datetime))
      event.createDateRow()
      $('#selected-dates .selected-date:last').append(elem)
    else
      console.log('false')
