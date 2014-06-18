# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :student_master do
    name "MyString"
    dob "2014-05-29"
    joining_date "2014-05-29"
    grade "MyString"
    section "MyString"
    academic_year "MyString"
    parent_id 1
  end
end
