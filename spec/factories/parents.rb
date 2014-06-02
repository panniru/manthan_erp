# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parent do
    father_name "MyString"
    mother_name "MyString"
    guardian_name "MyString"
    father_occupation "MyString"
    mother_occupation "MyString"
    guardian_occupation "MyString"
    father_phone "MyString"
    mother_phone "MyString"
    guardian_phone "MyString"
    father_email "MyString"
    mother_email "MyString"
    guardian_email "MyString"
    address "MyString"
  end
end
