# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :listing do
    subject_master_id 1
    lab_assessment_id 1
    grade_master_id 1
    assessment_date "2015-04-01"
    assessment_description "MyString"
    assessment_name "MyString"
  end
end
