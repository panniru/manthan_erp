# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :academic_term do
    term_name "MyString"
    from_date "2014-08-22"
    to_date "2014-08-22"
  end
end
