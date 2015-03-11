# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payslip do
    faculty_masters_id 1
    generated_date "2015-02-24"
    basic 1
    hra 1
    connveyance_allowance 1
    city_compensatory_allowance 1
    special_allowance 1
    loyalty_allowance 1
    medical_allowance 1
    arrears_of_salary 1
    incentive_payment 1
    loyalty_deposit 1
    grade_allowance 1
    leave_settlement 1
    performance_bonus 1
    annual_bonus 1
    additional_allowance_1 1
    additional_allowance_2 1
    additional_allowance_3 1
    pf 1
    club_contribution 1
    professional_tax 1
    tds_pm 1
    training_cost 1
    salary_advance 1
    additional_deduction_1 1
    additional_deduction_2 1
    additional_deduction_3 1
    notice_period_amount 1
    labour_welfare_fund 1
    voluntary_pf_contribution 1
    status "MyString"
  end
end
