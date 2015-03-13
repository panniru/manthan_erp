json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :description, :created_date, :occurrence
  json.url reminder_url(reminder, format: :json)
end
