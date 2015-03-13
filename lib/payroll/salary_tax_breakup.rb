module Payroll
  class SalaryTaxBreakup
    include Payroll::SalaryTaxComponents

    def self.income_tax_lap(amount)
      SalaryTax.tax_limits[:income_tax].each do |key, val|
        if val["to"].nil?  or amount <= val["to"]
          return val["tax"]
        end
      end
    end
    
    def self.income_tax_on_amount(amount)
      tax  = 0
      bucket_wise_tax = {}
      SalaryTax.tax_limits[:income_tax].each do |key, val|
        break if amount <= 0
        if val["to"].present?
          range = val["to"] - val["from"]
          if amount >= range
            bucket_tax = (range*(val["tax"].to_f/100))
            bucket_wise_tax[key] = bucket_tax.round
            tax = (tax + bucket_tax)
          else
            bucket_tax = (amount*(val["tax"].to_f/100))
            bucket_wise_tax[key] = bucket_tax.round
            tax = (tax + bucket_tax)
          end
          amount = amount - range
        else
          bucket_tax = (amount*(val["tax"].to_f/100))
          bucket_wise_tax[key] = bucket_tax.round
          tax = (tax + bucket_tax)
          amount = amount - val["from"]
        end
      end
      yield bucket_wise_tax if block_given?
      tax.round
    end

    def initialize(faculty_master, fin_year_from, fin_year_to)
      @faculty_master = faculty_master
      @fin_year_from = fin_year_from
      @fin_year_to = fin_year_to
    end

    def faculty_master
      @faculty_master
    end

    def financial_year_from
      @fin_year_from
    end


    def financial_year_to
      @fin_year_to
    end

    def payslip_components_monthly_report(component)
      payslips.map do |payslip|
        if payslip.respond_to? component.to_sym
          {
            payslip_id: payslip.id,
            month: payslip.generated_date.strftime("%b"),
            amount: payslip.send(component.to_sym)
          }
        else
          nil
        end 
      end
    end
  end
end
