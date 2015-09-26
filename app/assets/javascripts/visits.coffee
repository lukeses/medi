# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

send_request_form = () ->
  $.ajax 'form/update_visits',
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
  $(document).on 'change', '#visits_clinics_select', (evt) ->
    $.ajax 'form/update_visits',
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
    $.ajax 'form/update_visits',
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

$ ->
  $(document).on 'change', '#date_month', (evt) ->
    send_request_form()

$ ->
  $(document).on 'change', '#date_day', (evt) ->
    send_request_form()