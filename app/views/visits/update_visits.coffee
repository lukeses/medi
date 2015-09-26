$("#visits_doctors_select").empty()
  .append("<%= escape_javascript(render(:partial => @doctors)) %>")

$("#visits_doctors_select").val(<%= @doctor_id %>)

$("#visits").empty()
  .append("<%= escape_javascript(render :partial => 'possible_visits') %>")
