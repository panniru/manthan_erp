json.array!(@events) do |event|
  json.extract! event, :id, :title, :description, :staff, :grade, :start_time, :end_time
  json.start event.start_time
  json.end event.title
  json.url event_url(event, format: :html)
end