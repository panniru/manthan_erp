# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :approval_item do
    approved_by "MyString"
    defined_by "MyString"
    status "MyString"
    academic_year "MyString"
  end
end
