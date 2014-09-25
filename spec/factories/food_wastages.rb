# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :food_wastage do
    current_date "2014-09-23"
    wastage 1
  end
end
