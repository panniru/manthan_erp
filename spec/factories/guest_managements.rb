# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest_management do
    guest_name "MyString"
    guest_phone "MyString"
    guest_address "MyText"
    guest_email "MyString"
    purpose "MyString"
    follow_up "MyString"
    follow_up_date "2014-09-26"
    came_to_meet "MyString"
  end
end
