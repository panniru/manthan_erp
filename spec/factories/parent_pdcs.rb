# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :parent_pdc do
    parent_payment_master_id 1
    parent_payment_transaction_id 1
    amount_in_rupees 1
    cheque_number "MyString"
    clearence_date "2014-06-05"
    status "MyString"
    post_dated_cheque_id 1
  end
end
