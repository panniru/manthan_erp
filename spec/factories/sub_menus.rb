# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub_menu do
    sub_menu_name "MyString"
    icon_class "MyString"
    main_menu_id 1
  end
end
