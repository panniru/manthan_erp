# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :route do
    route_no "MyString"
    no_of_stops "MyString"
    lpp "MyString"
    distance "MyString"
    busno_up "MyString"
    busno_down "MyString"
    no_of_children 1
    sequence_no 1
  end
end
