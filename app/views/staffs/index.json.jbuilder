json.array!(@staffs) do |staff|
  json.extract! staff, :id, :staff_name, :staff_exp, :grade, :start_time, :end_time, :period, :date
  json.url staff_url(staff, format: :json)
end
