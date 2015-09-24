json.array!(@workhours) do |workhour|
  json.extract! workhour, :id, :weekday, :start, :finish, :work_id
  json.url workhour_url(workhour, format: :json)
end
