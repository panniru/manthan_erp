json.array!(@teaching_plans) do |teaching_plan|
  json.extract! teaching_plan,  :id, :teaching_date, :plan_month, :created_at,:updated_at
  json.start teaching_plan.teaching_date
  json.title teaching_plan.teaching_date
  json.description teaching_plan.plan_month
  json.url teaching_plan_url(teaching_plan, format: :html)
end