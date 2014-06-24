# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teacher_grade_mapping do
    user_id 1
    grade_master_id "MyString"
    section_master_id "MyString"
    subject_master_id "MyString"
  end
end
