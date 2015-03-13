module Payroll
  class SalaryBreakUpCreator
    include Payroll::SalaryBreakUpInitializer 
    basic_on_ctc :basic
    attr_on_basic :hra, :city_compensatory_allowance, :employer_pf_contribution, :bonus_payment #, :loyalty_allowance
    attr_fixed_per_year :conveyance_allowance, :medical_allowance
    #private_class_method :new

    EARNINGS = ["basic", "hra", "conveyance_allowance", "city_compensatory_allowance", "medical_allowance", "special_allowance", "loyalty_allowance" ] #, 
    DEDUCTIONS = ["employer_pf_contribution", "bonus_payment"]
    BREAK_UPS = EARNINGS + DEDUCTIONS + ["grade_allowance", "incentive_payment"]
    BREAK_UP_FORUMULA_DESC = {
      :basic => "% of CTC",
      :hra => "% of Basic", 
      :conveyance_allowance => "per Year", 
      :city_compensatory_allowance => "% of Basic", 
      :medical_allowance => "per Year", 
      :special_allowance => "Balancing Amount", 
      :employer_pf_contribution => "% of Basic", 
      :bonus_payment => "% of Basic",
      :loyalty_allowance => "% of Basic pay after the completion of 3 years of continuous service from probation",
      :epf_ee_share => "% of Basic", 
      :eps_share => "% of Basic", 
      :eps_upper_limit => "per Year",
      :professional_tax => "per Year",
      :educational_cess => "%",
      :surcharge => "%",
      :maintananace_on_rent_received => "%" 
    }

    def initialize(ctc, basic = nil, probation_date = nil, generated_date =nil, designation = nil)
      @ctc = ctc
      @basic = basic
      @probation_date = probation_date
      @generated_date = generated_date
      @designation = designation
    end


    def loyalty_allowance
      if eligible_for_loyality?(@probation_date, @generated_date)
        ((component_criterias[:loyalty_allowance]/100)*basic) #* eligibility_fraction)
      else
        0
      end
    end

    def bonus_payment
      if @designation.present? and @designation.downcase =~ /trainee/i
        if @probation_date.present?  #and @generated_date.present? and @generated_date >= @probation_date
          ((component_criterias[:bonus_payment]/100)*basic)
        else
          0
        end
      else
        ((component_criterias[:bonus_payment]/100)*basic)
      end 
    end

    # def self.get_instance(ctc)
    #   new(ctc)
    # end
    

    def to_h
      {
        earnings: EARNINGS.map{|component| salary_break_up_entity(component)},
        deductions: DEDUCTIONS.map{|component| salary_break_up_entity(component)},
        loyalty_allowance: salary_break_up_entity("loyalty_allowance")
      }
    end

    def salary_break_up_entity(component)
      {
        component: component.titleize.gsub("Hra", "HRA").gsub("Pf", "PF"),
        criteria: "#{component_criterias[component.to_sym]} #{BREAK_UP_FORUMULA_DESC[component.to_sym]}",
        amount_per_month: (send(component.to_sym)).round,
        amount_per_year: (send(component.to_sym)*12).round
      }
    end

    def eligible_for_loyality?(probation_date, generated_date)
      return false unless probation_date.present?
      date_before_3_years = Date.new(generated_date.year-3, generated_date.month, generated_date.day)
      probation_date <= date_before_3_years
    end
    private

    
    
    # def initialize(ctc)
    #   @ctc = ctc
    # end
    
  end
end
