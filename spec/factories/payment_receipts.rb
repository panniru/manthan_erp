# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_receipt do
    code "MyString"
    parent_payment_transaction_id 1
  end
end
