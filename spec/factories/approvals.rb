# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :approval, :class => 'Approvals' do
    approved "MyString"
    def_by "MyString"
    status "MyString"
    year "MyString"
  end
end
