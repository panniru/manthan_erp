# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assessment_grade_mapping do
    grade_master_id 1
    assessment_type_id 1
    no_of_times 1
  end
end
