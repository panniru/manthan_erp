# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :assessment_criterium, :class => 'AssessmentCriteria' do
    subject_master_id 1
    grade_master_id 1
    subject_criteria "MyString"
  end
end
