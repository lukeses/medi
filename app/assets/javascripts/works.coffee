# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).on 'change', '#doctors_select', (evt) ->
    $.ajax 'form/update_clinics',
      type: 'GET'
      dataType: 'script'
      data: {
        doctor_id: $("#doctors_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic doctor select OK!")