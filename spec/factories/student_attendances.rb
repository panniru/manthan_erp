# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_attendance do
    grade_master_id 1
    section_master_id 1
    student_master_id 1
    date "2014-07-24"
    status "MyString"
  end
end
