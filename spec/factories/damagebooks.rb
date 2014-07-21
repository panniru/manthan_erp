# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :damagebook do
    isbn "MyString"
    book_stage "MyString"
    damage_type "MyString"
    damage_description "MyString"
  end
end
