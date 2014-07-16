json.array!(@admissions) do |admission|
  json.extract! admission, :id, :title, :start_time
  json.start admission.start_time
  json.title admission.title
  json.end admission.end_time
  json.description admission.title
  json.url admission_url(admission, format: :html)
end