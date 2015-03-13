module Payroll
  class Form16

    def initialize(faculty_master, salary_tax)
      @faculty_master = faculty_master
      @salary_tax = salary_tax
    end

    def salary_tax
      @salary_tax
    end

    def quarter_1_tax_paid
      payslips = @faculty_master.payslips.generated_between(financial_year.quarter_1_range.first, financial_year.quarter_1_range.last)
      payslips.inject(0){|sum, payslip| sum + payslip.tds_pm.to_i}
    end
    
    def quarter_2_tax_paid
      payslips = @faculty_master.payslips.generated_between(financial_year.quarter_2_range.first, financial_year.quarter_2_range.last)
      payslips.inject(0){|sum, payslip| sum + payslip.tds_pm.to_i}
    end

    def quarter_3_tax_paid
      payslips = @faculty_master.payslips.generated_between(financial_year.quarter_3_range.first, financial_year.quarter_3_range.last)
      payslips.inject(0){|sum, payslip| sum + payslip.tds_pm.to_i}
    end

    def quarter_4_tax_paid
      payslips = @faculty_master.payslips.generated_between(financial_year.quarter_4_range.first, financial_year.quarter_4_range.last)
      payslips.inject(0){|sum, payslip| sum + payslip.tds_pm.to_i}
    end

    def hra_medical_bill_conveyance
      (salary_tax.hra + salary_tax.claimed_medical_bill + salary_tax.conveyance_allowance)
    end

    def professional_tax_others
      salary_tax.professional_tax
    end

    def income_under_head_salaries
      (salary_tax.total_earnings - hra_medical_bill_conveyance - professional_tax_others)
    end

    def gross_total_income
      income_under_head_salaries
    end

    def infrastructure_bond
      nil.to_i
    end
    
    def lic_premium_and_others
      salary_tax.savings_total_without_pf
    end

    def deductible_pf_amount
      (salary_tax.pf > salary_tax.class.tax_limits[:savings_up_to] ? salary_tax.class.tax_limits[:savings_up_to] : salary_tax.pf)
    end

    def deductible_lic_premium_and_others
      savings_left_over_maount = (salary_tax.class.tax_limits[:savings_up_to] - deductible_pf_amount)
      lic_premium_and_others > savings_left_over_maount ? savings_left_over_maount : lic_premium_and_others
    end

    def total_deductions_under_VI_A
      (salary_tax.pf + infrastructure_bond + lic_premium_and_others)
    end

    def deductible_amount_under_VI_A
      total_deductions_under_VI_A >= 120000 ? 120000 : total_deductions_under_VI_A
    end

    def section_80_d
      salary_tax.medical_insurances_total.to_i
    end

    def section_80_e
      0
    end

    def section_80_g
      salary_tax.atg.to_i
    end

    def deductible_amount_sections
      (section_80_d + section_80_e + section_80_g)
    end

    def aggregatable_deductible_amount
      deductible_amount_under_VI_A + deductible_amount_sections
    end

    def total_income
      gross_total_income - aggregatable_deductible_amount
    end
    
    def tax_on_total_income
      Payroll::SalaryTaxBreakup.income_tax_on_amount(total_income)
    end

    def educational_cess
      (tax_on_total_income * 0.03)
    end

    def tax_payble
      tax_on_total_income + educational_cess
    end

    def relief_under_Section_89
      0
    end

    def tax_payble_1
      tax_payble - relief_under_Section_89
    end

    def net_tax
      tax_payble-1 - salary_tax.tax_paid
    end

    def certificate_no
      "#{assessment_year}/#{@faculty_master.code.gsub('HTI/', '')}"
    end

    def assessment_year
      "#{@salary_tax.financial_year_to.year} - #{@salary_tax.financial_year_to.year+1}"
    end

    def payslips
      PayslipDecorator.decorate_collection(salary_tax.payslips)
    end
    
    private
    
    def financial_year
      @financial_year ||=  Payroll::FinancialYearCalculator.new(@salary_tax.financial_year_from)
    end

  end

end
