# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :request_book do
    book_name "MyString"
    author_name "MyString"
    status "MyString"
  end
end
