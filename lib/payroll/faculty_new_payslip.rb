module Payroll
  class FacultyNewPayslip
    include Payroll::SalaryBreakUpInitializer 
    basic_on_ctc :basic
    attr_on_basic :hra, :city_compensatory_allowance, :employer_pf_contribution, :bonus_payment #, :loyalty_allowance
    attr_fixed_per_year :conveyance_allowance, :medical_allowance
    alias_method :pf, :employer_pf_contribution
    
    def initialize(faculty, generation_date)
      @ctc = faculty.ctc
      @basic = faculty.basic
      @faculty = faculty
      @generation_date = generation_date
      # @total_days = total_days
      # @worked_days = worked_daysg
    end

    def payslip(inject_defaults = true)
      leave_details
      payslip = Payslip.new
      payslip.faculty_master_id = @faculty.id
      payslip.generated_date = @generation_date
      payslip.attributes.each do |attribute, value|
        if self.respond_to? attribute.to_sym and payslip.respond_to? "#{attribute}="
          payslip.send("#{attribute}=", self.send(attribute).try(:round)) 
        end
      end
      if inject_defaults
        inject_monthly_input_components_from_prvious_month(payslip)
        set_tds(payslip)
      end
      payslip.bonus_payment = bonus_payment
      payslip
    end

    # menthod_name should be same as payslip attribute salary_advance
    def salary_advance
      advs = @faculty.employee_advance_payments.belongs_to_month(@generation_date.strftime("%b")).belongs_to_year(@generation_date.strftime("%Y"))
      advs.inject(0){|sum, adv| sum+adv.amount_in_rupees}
    end

    # menthod_name should be same as payslip attribute salary_advance
    def leave_settlement
      if @faculty.eligible_for_leave_settlement?(@generation_date)
        leaves_to_encash = LeaveEncashment.employee_leave_encashments(@faculty, @generation_date.year.to_s).first.try(:no_of_leaves_to_be_encashed).to_i
        ((basic.to_f/@generation_date.end_of_month.day) * leaves_to_encash)
      end
    end

    # menthod_name should be same as payslip attribute loyalty_allowance
    def loyalty_allowance
      if @faculty.eligible_for_loyality_allowance?(@generation_date)
        ((component_criterias[:loyalty_allowance]/100)*basic) #* eligibility_fraction)
      end
    end

    def bonus_payment
      if @faculty.designation_master.present? and @faculty.designation_master.name.downcase =~ /trainee/i
        if @faculty.probation_date.present? and @generation_date.present? and @generation_date >= @faculty_master.probation_date
          ((component_criterias[:bonus_payment]/100)*basic)
        else
          0
        end
      else
        ((component_criterias[:bonus_payment]/100)*basic)
      end 
    end

    
    # menthod_name should be same as payslip attribute annual_bonus
    def annual_bonus
      if @faculty.eligible_for_annual_bonus_payment?(@generation_date)
        last_annual_bonus_paid_on = @faculty.last_annual_bonus_paid_on
        unless last_annual_bonus_paid_on.present?
          last_annual_bonus_paid_on = Date.new(@generation_date.year-1, @faculty.rule_engine(:bonus_payment_month)+1, 1)
        end
        EmployerContribution.belongs_to_employee(@faculty).generated_after(last_annual_bonus_paid_on).inject(0){|sum, contrib| sum+contrib.bonus_payment}
      end
    end

    def labour_welfare_fund
      if @faculty.eligible_for_labour_welfare_fund?(@generation_date)
        component_criterias[:employee_labour_welfare_fund]
      end
    end

    def special_allowance
      (@faculty.special_allowance * eligibility_fraction).round
    end

    def professional_tax
      @faculty.rule_engine(:professional_tax)
    end



    private

    
    def leave_details
      employee_leaves = @faculty.leaves_taken_in_the_month(@generation_date)
      if employee_leaves.present?
        @total_days = employee_leaves.working_days
        @worked_days = employee_leaves.days_worked
        # if employee_leaves.lop.present? 
        #   @worked_days = @total_days - employee_leaves.lop
        # else
        #   @total_days
        # end
      end
    end

    def inject_monthly_input_components_from_prvious_month(payslip)
      old_payslip = @faculty.payslips.in_the_current_month(@generation_date.last_month).first
      if old_payslip.present?
        DefaultAllowanceDeduction.valid_attributes.each do |key|
          if payslip.respond_to? key
            payslip.send("#{key}=", old_payslip.send(key))
          end
        end
      else
        inject_monthly_input_components_from_defaults(payslip)
      end
      
    end

    def inject_monthly_input_components_from_defaults(payslip)
      dafault_values = DefaultAllowanceDeduction.belongs_to_employee(@faculty).first
      if dafault_values.present?
        DefaultAllowanceDeduction.valid_attributes.each do |key|
          if payslip.respond_to? key
            payslip.send("#{key}=", dafault_values.send(key))
          end
        end
      end
    end

    def set_tds(payslip)
      financial_year =  Payroll::FinancialYearCalculator.new(@generation_date)
      salary_tax_for_current_year = @faculty.salary_taxes.in_the_financial_year(financial_year.financial_year_from, financial_year.financial_year_to).first
      if salary_tax_for_current_year.present?
        balance_tax = salary_tax_for_current_year.balance_tax
        tax_paid_months = salary_tax_for_current_year.existed_payslips.count
        unless tax_paid_months >= 12
          remaining_tax_per_month = (balance_tax.to_f/(12 - tax_paid_months))
        else
          remaining_tax_per_month = 0
        end
        payslip.tds_pm = remaining_tax_per_month.round
      end
    end
  end
end
