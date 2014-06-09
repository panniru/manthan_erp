# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parent_payment_transaction do
    parent_payment_master_id 1
    transaction_date "2014-06-05"
    amount_in_rupees 1
    transaction_type "MyString"
    particulars "MyString"
    academic_year "MyString"
  end
end
