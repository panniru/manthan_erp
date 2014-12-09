# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setup_master do
    casual_leave 1.5
    sick_leave 1.5
  end
end
