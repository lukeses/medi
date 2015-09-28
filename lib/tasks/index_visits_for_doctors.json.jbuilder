json.array!(@visits) do |visit|
  json.extract! visit, :id, :start, :finish, :patient_id, :doctor_id, :clinic_id, :confirmed
  json.url visit_url(visit, format: :json)
end
