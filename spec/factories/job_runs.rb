# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_run do
    job_id 1
    started_on "2014-05-28 18:09:29"
    finished_on "2014-05-28 18:09:29"
    status "MyString"
  end
end
