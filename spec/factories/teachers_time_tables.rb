# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :teachers_time_table do
    faculty_id 1
    academic_year "MyString"
    period_id 1
    mon_grade_section "MyString"
    tue_grade_section "MyString"
    wed_grade_section "MyString"
    thu_grade_section "MyString"
    fri_grade_section "MyString"
    sat_grade_section "MyString"
    sun_grade_section "MyString"
  end
end
