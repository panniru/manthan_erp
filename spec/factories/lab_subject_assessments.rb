# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_subject_assessment do
    lab_assessment_id 1
    subject_master_id 1
    assessment_name "MyString"
  end
end
