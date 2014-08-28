# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attendance do
    grade_master_id 1
    section_master_id 1
    faculty_master_id 1
    student_master_id 1
    attendance "MyString"
  end
end
