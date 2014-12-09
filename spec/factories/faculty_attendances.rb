# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faculty_attendance do
    faculty_master_id 1
    designation "MyString"
    forenoon "MyString"
    afternoon "MyString"
    attendance_date "MyString"
    name "MyString"
  end
end
