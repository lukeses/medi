json.array!(@works) do |work|
  json.extract! work, :id, :doctor_id, :clinic_id
  json.url work_url(work, format: :json)
end
