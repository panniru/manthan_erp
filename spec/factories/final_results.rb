# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :final_result do
    grade_master_id 1
    assessment_type_id 1
    no_of_times 1
    student_master_id 1
    grading_default_id 1
    scored_marks "MyString"
  end
end
