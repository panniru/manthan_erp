# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_result do
    grading_master_id 1
    student_master_id 1
    listing_id 1
  end
end
