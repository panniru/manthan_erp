# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :communication_mail do
    from 1
    to 1
    message_id 1
    red false
  end
end
