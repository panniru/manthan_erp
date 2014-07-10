# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :new_vehicle do
    model_no "MyString"
    make_of_bus "MyString"
    yom "2014-07-08"
    purchase_option "MyString"
    purchase_option_date "2014-07-08"
    capacity 1
  end
end
