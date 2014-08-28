# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    code "MyString"
    description "MyString"
    job_type "MyString"
  end

  factory :fee_structure_mailing, :class => Job do |job|
    code "fee_structure_mailing"
    description "Fee Structure Mailing"
    job_type "mailing"
  end

  factory :route_mailing, :class => Job do |job|
    code "route_mailing"
    description "Route Mailing"
    job_type "mailing"
  end

  factory :special_route_mailing, :class => Job do |job|
    code "special_route_mailing"
    description "Special Route Mailing"
    job_type "mailing"
  end
  

  
end
