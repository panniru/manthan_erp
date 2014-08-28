# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mealname do
    meal_type_id "MyString"
    meal_detail_name "MyString"
    canteen_date "2014-08-20"
  end
end
