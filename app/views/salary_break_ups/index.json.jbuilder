json.array!(@salary_break_ups) do |salary_break_up|
  json.extract! salary_break_up, :id, :component, :criteria, :component_description
  json.url salary_break_up_url(salary_break_up, format: :json)
end
