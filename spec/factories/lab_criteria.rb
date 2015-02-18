# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab_criterium, :class => 'LabCriteria' do
    lab_master_id 1
    lab_criteria "MyString"
    grade_master_id 1
  end
end
