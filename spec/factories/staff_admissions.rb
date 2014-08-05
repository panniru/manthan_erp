# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :staff_admission do
    form_no "MyString"
    name "MyString"
    dob "MyString"
    gender "MyString"
    email "MyString"
    mobile_no "MyString"
    address "MyText"
    nationality "MyString"
    klass "MyString"
    language "MyString"
    subject "MyString"
    experience "MyString"
    expected_salary "MyString"
    education_qualification "MyString"
    status "MyString"
  end
end
