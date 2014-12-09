# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leave_permission do
    faculty_master_id 1
    type_of_leave "MyString"
    from_date "MyString"
    to_date "MyString"
    reason "MyString"
    status "MyString"
    bal_leave 1.5
    casual_leave_count 1.5
    sick_leave_count 1.5
    faculty_attendance_id 1
  end
end
