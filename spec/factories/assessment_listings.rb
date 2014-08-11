# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assessment_listing do
    faculty_master_id 1
    grade_master_id 1
    section_master_id 1
    subject_master_id 1
    assessment_type_id 1
    assessment_desc "MyString"
    assessment_date "2014-08-11"
  end
end
