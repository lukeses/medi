# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

send_request_form = () ->
  $.ajax '/visits/form/update_visits',
    type: 'GET'
    dataType: 'script'
    data: {
      clinic_id: $("#visits_clinics_select option:selected").val(),
      doctor_id: $("#visits_doctors_select option:selected").val(),
      date_year: $("#date_year option:selected").val(),
      date_month: $("#date_month option:selected").val(),
      date_day: $("#date_day option:selected").val(),
    }
    error: (jqXHR, textStatus, errorThrown) ->
      console.log("AJAX Error: #{textStatus}")
    success: (data, textStatus, jqXHR) ->
      console.log("Dynamic doctor select OK!")

disable_create_visit = () ->
  $('#create_visit_button').prop( "disabled", true )


enable_create_visit = () ->
  $('#create_visit_button').prop( "disabled", false )


$ ->
  $(document).on 'change', '#visits_clinics_select', (evt) ->
    disable_create_visit()
    $.ajax '/visits/form/update_visits',
      type: 'GET'
      dataType: 'script'
      data: {
        clinic_id: $("#visits_clinics_select option:selected").val(),
        doctor_id: $("#visits_doctors_select option:selected").val(),
        date_year: $("#date_year option:selected").val(),
        date_month: $("#date_month option:selected").val(),
        date_day: $("#date_day option:selected").val(),
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic doctor select OK!")

$ ->
  $(document).on 'change', '#visits_doctors_select', (evt) ->
    disable_create_visit()
    $.ajax '/visits/form/update_visits',
      type: 'GET'
      dataType: 'script'
      data: {
        clinic_id: $("#visits_clinics_select option:selected").val(),
        doctor_id: $("#visits_doctors_select option:selected").val(),
        date_year: $("#date_year option:selected").val(),
        date_month: $("#date_month option:selected").val(),
        date_day: $("#date_day option:selected").val(),
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic doctor select OK!")

$ ->
  $(document).on 'change', '#date_year', (evt) ->
    send_request_form()
    disable_create_visit()

$ ->
  $(document).on 'change', '#date_month', (evt) ->
    send_request_form()
    disable_create_visit()

$ ->
  $(document).on 'change', '#date_day', (evt) ->
    send_request_form()
    disable_create_visit()

$ ->
  $(document).on 'change', '#visits', (evt) ->
    if $('input[name=visit_start]:checked').length > 0
      enable_create_visit()

$ ->
  disable_create_visit()