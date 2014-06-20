json.array!(@interviewschedulers) do |interviewscheduler|
  json.extract! interviewscheduler, :id, :name, :description, :start_time, :end_time
  json.start interviewscheduler.start_time
  json.end interviewscheduler.end_time
  json.url interviewscheduler_url(interviewscheduler, format: :html)
end
