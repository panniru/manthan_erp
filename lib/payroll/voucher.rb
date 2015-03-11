module Payroll
  class Voucher
    
    def initialize(payslips)
      @payslips = payslips
    end

    def net_pay_account
      (toal_earnings - total_deductions)
    end

    def total_rhs
      (net_pay_account + total_deductions)
    end

    def total_lhs
      toal_earnings
    end

    def toal_earnings
      (salary + incentive + grade_allowance + leave_encashment + bonus)
    end

    def total_deductions
      provident_fund + club_contribution + professional_tax + salary_incometax + salary_advance + labour_welfare + training_cost + additional_deductions
    end

    def training_cost
      payslips_aggregation.get_total_of("training_cost".to_sym)
    end

    def additional_deductions
      [:additional_deduction_1, :additional_deduction_2, :additional_deduction_3].inject(0) do|sum, deduction|
        sum + payslips_aggregation.get_total_of(deduction.to_sym).to_i
      end 
    end
    
    def salary
      [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :performance_bonus].inject(0) do|sum, earning|
        sum + payslips_aggregation.get_total_of(earning.to_sym).to_i
      end 
    end

    def incentive
      payslips_aggregation.get_total_of("incentive_payment".to_sym)
    end

    def grade_allowance
      payslips_aggregation.get_total_of("grade_allowance".to_sym)
    end

    def leave_encashment
      payslips_aggregation.get_total_of("leave_settlement".to_sym)
    end

    def bonus
      payslips_aggregation.get_total_of("annual_bonus".to_sym)
    end

    def shortfall_in_notice
      payslips_aggregation.get_total_of("notice_period_amount".to_sym)
    end

    def provident_fund
      payslips_aggregation.get_total_of("pf".to_sym)
    end

    def club_contribution
      payslips_aggregation.get_total_of("club_contribution".to_sym)
    end

    def professional_tax
      payslips_aggregation.get_total_of("professional_tax".to_sym)
    end

    def salary_incometax
      payslips_aggregation.get_total_of("tds_pm".to_sym)
    end

    def salary_advance
      payslips_aggregation.get_total_of("salary_advance".to_sym)
    end

    def labour_welfare
      payslips_aggregation.get_total_of("labour_welfare_fund".to_sym)
    end

    def xls(month, year)
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => "Salary_voucher_#{month}_#{year}"
    rows = [
            ["Salary", salary, nil],
            ["Incetive", incentive, nil],
            ["Grade Allowance", grade_allowance, nil],
            ["Leave Encashment", leave_encashment, nil],
            ["Bonus", bonus, nil],
            ["Shortfall In Notice", nil, nil],
            ["Provident Fund", nil, provident_fund],
            ["Club Contribution", nil, club_contribution],
            ["Professional Tax", nil, professional_tax],
            ["Salary Incometax", nil, salary_incometax],
            ["Salary Advance", nil, salary_advance],
            ["Labour Welfare", nil, labour_welfare],
            ["Shortfall in Notice", nil, shortfall_in_notice],
            ["NET PAY ACCOUNT", nil, net_pay_account],
            ["Total", total_lhs, total_rhs]
           ]
    rows.each_with_index do |row, index|
      sheet1.insert_row(index, row)
    end 
    book
  end
    
    private
    
    def payslips_aggregation
      @payslip_aggregation ||= Payroll::PayslipsAggregation.new(@payslips)
    end
  end
end
