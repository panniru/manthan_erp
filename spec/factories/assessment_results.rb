# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assessment_result do
    assessment_listing_id 1
    student_master_id 1
    assessment_result_desc "MyString"
  end
end
