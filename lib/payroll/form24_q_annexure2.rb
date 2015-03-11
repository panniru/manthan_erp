module Payroll
  class Form24QAnnexure2
    attr_accessor :salary_tax
    
    def initialize(salary_tax)
      @salary_tax = salary_tax
    end

    def employee_pan
      salary_tax.faculty_master.pan
    end

    def employee_name
      salary_tax.faculty_master.faculty_name
    end

    def employee_gender_consideration
      salary_tax.faculty_master.gender == 'F' ? 'W' : 'G'
    end

    def employee_joining_date
      salary_tax.faculty_master.date_of_joining
    end
    
    def feild_332
      salary_tax.form16.income_under_head_salaries
    end

    def feild_333
      0 
    end
    
    def feild_334
      feild_332
    end

    def feild_335
      salary_tax.final_hra_component
    end

    def feild_336
      feild_334 - feild_335
    end

    def feild_337
      salary_tax.savings_total
    end

    def feild_338
      salary_tax.medical_insurances_total
    end
    
    def feild_339
      feild_337 + feild_338
    end

    def feild_340
      feild_336 - feild_339
    end

    def feild_341
      Payroll::SalaryTaxBreakup.income_tax_on_amount(feild_340).round
    end

    def feild_342
      salary_tax.surcharge
    end

    def feild_343
      (feild_341 * (salary_tax.class.tax_limits[:educational_cess].to_f/100)).round
    end

    def feild_344
      0
    end

    def feild_345
      feild_341 + feild_343
    end

    def feild_346
      salary_tax.tax_paid
    end

    def feild_347
      feild_345 - feild_346
    end

  end
end
