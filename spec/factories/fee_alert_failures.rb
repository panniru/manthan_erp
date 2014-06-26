# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fee_alert_failure do
    e_mail "MyString"
    job_run_id 1
    remarks "MyString"
    parent_id 1
  end
end
