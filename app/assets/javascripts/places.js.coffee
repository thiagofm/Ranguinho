# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # slider widget
  $("#slider-distance-min").slider
    range: "min"
    min: 1
    value: $('#_places_maximum_distance').attr('val') || 5
    max: 20
    slide: (event, ui) ->
      $("#_places_maximum_distance").val ui.value
    change: (event, ui) ->
      $('#filters').submit()

  $("#_places_maximum_distance").val $("#slider-distance-min").slider("value")

  $('#review-place').popover
    delay: { show: 200, hide: 200 }
    placement: 'bottom'
