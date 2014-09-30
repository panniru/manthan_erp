# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donate_book do
    book_id 1
    student_name "MyString"
    grade_name "MyString"
    section_name "MyString"
    date_of_donation "2014-09-26"
  end
end
