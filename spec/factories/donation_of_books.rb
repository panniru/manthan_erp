# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donation_of_book do
    book_name "MyString"
    isbn "MyString"
    year_of_publishing "MyString"
    number_of_copies "MyString"
    book_type "MyString"
    student_name "MyString"
    section "MyString"
    grade "MyString"
  end
end
