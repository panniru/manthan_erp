module Payroll
  class FacultyNewPfStatement
    def initialize(payslip)
      @payslip = payslip
    end
    
    def pf_statement
      pf_statement = PfStatement.new 
      pf_statement.attributes.keys.each do |attribute|
        if self.respond_to?attribute
          pf_statement.send("#{attribute}=".to_sym, send(attribute.to_sym))
        end
      end
      pf_statement.faculty_master = @payslip.faculty_master
      pf_statement
    end
    
    def epf_wages
      @payslip.basic
    end

    def eps_wages
      if self.class.pf_break_up[:eps_upper_limit].present?
        @payslip.basic > self.class.pf_break_up[:eps_upper_limit] ? self.class.pf_break_up[:eps_upper_limit] : @payslip.basic
      else
        @payslip.basic
      end
    end

    def epf_ee_share
      epf_ee_share_original + @payslip.voluntary_pf_contribution.to_i
    end

    def epf_ee_share_original
      ((self.class.pf_break_up[:epf_ee_share].to_f/100)*epf_wages).round
    end
    
    def epf_ee_remitted
      epf_ee_share
    end

    def eps_due
      ((self.class.pf_break_up[:eps_share].to_f/100)*eps_wages).round
    end
    
    def eps_remitted
      eps_due
    end

    def n
      @payslip.faculty_master.leaves_taken_in_the_month(@payslip.generated_date).try(:lop).to_i
    end

    def diff_epf_and_eps
      epf_ee_share_original - eps_due
    end

    def diff_remitted
      diff_epf_and_eps
    end

    def self.pf_break_up
      @@component_criterias ||= SalaryBreakUp.belongs_to_pf.map{|break_up| [break_up.component_code.to_sym, break_up.criteria] }.to_h
    end

  end
end
