# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :special_day_transport do
    new_route_no "MyString"
    location_master_id 1
    route_id 1
    new_up_route "MyString"
    new_down_route "MyString"
    new_busno_up "MyString"
    new_busno_down "MyString"
    time_up "MyString"
    time_down "MyString"
    date "2014-08-25"
    occation "MyString"
  end
end
