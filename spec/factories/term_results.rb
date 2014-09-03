# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term_result do
    academic_term_id 1
    grade_master_id 1
    section_master_id 1
    student_master_id 1
    assessment_criteria_id 1
    grading_master_id 1
  end
end
