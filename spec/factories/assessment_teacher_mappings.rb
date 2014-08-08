# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assessment_teacher_mapping do
    faculty_master_id 1
    grade_master_id 1
    section_master_id 1
    assessment_type_id 1
  end
end
