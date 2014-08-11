# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request_new_book do
    book_name "MyString"
    author_name "MyString"
  end
end
