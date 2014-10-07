# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vendor_management do
    vendor_name "MyString"
    vendor_categories_id 1
    vendor_phone "MyString"
    vendor_email "MyString"
    vendor_alternate_email "MyString"
    vendor_address "MyText"
    verdor_mobile "MyString"
  end
end
