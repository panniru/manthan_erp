# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parent_payment_master do
    parent_id 1
    student_id 1
    payment_type_id 1
    next_payment_date "2014-06-04"
  end
end
