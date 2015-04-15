# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_assessment_grade_mapping do
    assessment_type_id 1
    grade_master_id 1
    no_of_times 1
  end
end
