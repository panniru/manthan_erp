json.array!(@staffrecruits) do |staffrecruit|
  json.extract! staffrecruit, :id, :title, :start_time
  json.start staffrecruit.start_time
  json.title staffrecruit.title
  json.end staffrecruit.start_time
  json.description staffrecruit.title
  json.url staffrecruit_url(staffrecruit, format: :html)
end