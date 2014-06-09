# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fee_structure_approval do
    approved_by "MyString"
    defined_by "MyString"
    status "MyString"
    academic_year "MyString"
  end
end
