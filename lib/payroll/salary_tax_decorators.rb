module Payroll
  module SalaryTaxDecorators

    def educational_cess
      (tax_projected * (tax_limits[:educational_cess].to_f/100)).round
    end
    
    def surcharge
      if total_amount_to_tax > tax_limits[:surcharge_limit]
        (tax_limits[:surcharge_limit].to_f/100) * total_amount_to_tax
      else
        0
      end
    end

    def bucket_wise_tax
      if @bucket_wise_tax.nil?
        tax_projected
      end
      @bucket_wise_tax
    end
    
    def tax_projected
      Payroll::SalaryTaxBreakup.income_tax_on_amount(total_amount_to_tax) do |b_w_tax|
        @bucket_wise_tax= b_w_tax
      end
    end

    def rent_per_year
      rent_per_month.to_i * 12
    end
    
    def rent_paid_in_excess_of_salary
      (rent_per_year - (basic * 0.1)).abs
    end

    def rent_paid
      return 0 if rent_per_year <= 0
      [rent_paid_in_excess_of_salary, hra].min
    end

    def rent_received_per_year
      (rent_received_per_month.to_i * 12)
    end

    def rent_received
      maintanace_cost = tax_limits[:maintanance_on_rent_received]
      rent_after_pt_and_wt = rent_received_per_year.to_i - pt_and_wt.to_i
      rent_after_pt_and_wt - (rent_after_pt_and_wt * maintanace_cost.to_f/100)
    end
    
    def eligible_home_loan_interest
      if employee_home_loan_interest.present?
        employee_home_loan_interest > tax_limits[:home_loan_interest_limit] ? tax_limits[:home_loan_interest_limit] : employee_home_loan_interest
      end
    end

    def final_hra_component
      if occupancy_type == 'rent'
        rent_paid
      elsif occupancy_type == 'let_out'
        if rent_received <= 0
          rent_paid - rent_received + eligible_home_loan_interest
        else
          rent_paid + employee_home_loan_interest
        end
      elsif occupancy_type == 'own'
        eligible_home_loan_interest
      end
    end


    def total_deductions
      (final_hra_component.to_i  + standard_deduction.to_i + medical_insurances_total + claimed_medical_bill + savings_total + professional_tax.to_i + conveyance_allowance + atg.to_i)
    end
    
    def total_amount_to_tax
      total_earnings - total_deductions
    end

    def net_tax
      educational_cess + surcharge + tax_projected
    end

    def balance_tax
      net_tax - tax_paid.to_i
    end

    def tax_paid
      existed_payslips.inject(0){|sum, payslip| sum + payslip.tds_pm.to_i}.round
    end
    
    def existed_payslips_count
      existed_payslips.count
    end

    def count_of_payslips_to_create_in_the_year  
      if existed_payslips.present?
        Payroll::FinancialYearCalculator.new(existed_payslips.last.generated_date).remaining_months_in_the_fianancial_year.to_i if existed_payslips.present?
      else
        0
      end
    end

    def balance_tax_per_remaining_months_each
      if count_of_payslips_to_create_in_the_year > 0
        (balance_tax.to_f/count_of_payslips_to_create_in_the_year).round
      else
        balance_tax
      end
    end
    
    def total_income
      total_earnings
    end

    def tax_limits
      @tax_limits ||= SalaryTax.tax_limits
    end
  end
end
