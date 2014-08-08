# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :block_book do
    isbn "MyString"
    blocked_by "MyString"
  end
end
