class SalaryTax < ActiveRecord::Base
  belongs_to :faculty_master
  has_many :medical_insurances
  has_many :medical_bills
  has_many :savings
  include Payroll::SalaryTaxComponents
  include Payroll::SalaryTaxDecorators
  
  #attr_accessor :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :leave_settlement, :medical_allowance, :other_payment, :pf, :tds_pm, :total_Earnings, :professional_tax
  
  
  
  scope :in_the_financial_year, lambda{|fin_year_from, fin_year_to| where(:financial_year_from => fin_year_from, :financial_year_to => fin_year_to)}
  scope :manageable_by_current_user, lambda{|current_user| where(:faculty_master_id => FacultyMaster.managed_by(current_user))}
  
  
  def form16
    @form16 ||=  Payroll::Form16.new(faculty_master, self)
  end
  
  def claimed_medical_bill
    total = medical_bills.inject(0){|sum, bill| sum+bill.amount.to_i}
    total > medical_allowance ? medical_allowance : total
  end

  def medical_insurances_total
    employee_insurance_amount = 0
    parent_insurance_amount = 0
    parent_senior_citizen_amount = 0
    medical_insurances.each do |insurance| 
      if insurance.parent_included
        parent_insurance_amount = parent_insurance_amount + insurance.amount.to_i 
      elsif insurance.parent_senior_citizen
         parent_senior_citizen_amount = parent_senior_citizen_amount + insurance.amount.to_i 
      else
       employee_insurance_amount = employee_insurance_amount + insurance.amount.to_i 
      end
    end
    parent_senior_citizen_limit = (self.class.tax_limits[:mediclaim_parent_limit] + self.class.tax_limits[:mediclaim_parent_senior_citizen_limit])
    employee_insurance_amount = (employee_insurance_amount > self.class.tax_limits[:mediclaim_employee_limit] ? self.class.tax_limits[:mediclaim_employee_limit] : employee_insurance_amount)
    parent_insurance_amount = (parent_insurance_amount > self.class.tax_limits[:mediclaim_parent_limit] ? self.class.tax_limits[:mediclaim_parent_limit] : parent_insurance_amount)
    parent_senior_citizen_amount = (parent_senior_citizen_amount > parent_senior_citizen_limit ? parent_senior_citizen_limit : parent_senior_citizen_amount)
    (employee_insurance_amount + parent_insurance_amount + parent_senior_citizen_amount)
  end

  def savings_total
    other_savings = savings_total_without_pf
    total = other_savings + pf
    (total > self.class.tax_limits[:savings_up_to] ? self.class.tax_limits[:savings_up_to] : total)
  end

  def savings_total_without_pf
    savings.inject(0){|sum, saving| sum+saving.amount.to_i}
  end

  def title
    "Salary Tax #{financial_year_from.strftime("%Y")} - #{financial_year_to.strftime("%Y")[2..3]}"
  end
  
  class << self   
    
    def tax_limits
      {
        mediclaim_employee_limit: default_values["mediclaim_employee_limit"],
        mediclaim_parent_limit: default_values["mediclaim_parent_limit"],
        mediclaim_parent_senior_citizen_limit: default_values["mediclaim_parent_senior_citizen_limit"],
        savings_up_to: default_values["savings_up_to"],
        income_tax: income_tax_values,
        educational_cess: default_values["educational_cess"],
        maintanance_on_rent_received: default_values["maintanance_on_rent_received"],
        home_loan_interest_limit: default_values["home_loan_interest_limit"],
        surcharge_limit: default_values["surcharge_limit"],
        surcharge: default_values["surcharge"]
      }
    end
    
    def rule_engine
      @@rule_engine ||= RuleEngine.new
    end
    def default_values
      @@default_values ||= fetch_default_values_map
    end
    
    def income_tax_values
      @@income_tax_values ||= income_tax_map
    end
    
    private    
    
    def fetch_default_values_map
      datault_values = {}
      SalaryBreakUp.belongs_to_default.each do |break_up|
        datault_values[break_up.component_code] =  break_up.criteria
      end
      datault_values
    end

    def income_tax_map
      {"bucket_1"=>{"from"=>0, "to"=>250000, "range"=>nil, "tax"=>0}, "bucket_2"=>{"from"=>250000, "to"=>500000, "tax"=>10}, "bucket_3"=>{"from"=>500000, "to"=>1000000, "tax"=>20}, "bucket_4"=>{"from"=>1000000, "tax"=>30}}
      buckets = {}
      TaxBucket.all.order("id").each_with_index do |bucket, index|
        bucket_value = {}
        bucket_value["from"] = bucket.from if bucket.from.present?
        bucket_value["to"] = bucket.to if bucket.to.present?
        bucket_value["tax"] = bucket.tax
        buckets["bucket_#{index+1}"] = bucket_value
      end
      buckets
    end
    
    
  end
  
  def as_json
    super(:include =>  [:savings, :medical_insurances, :medical_bills], :methods => [:basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :leave_settlement, :medical_allowance, :other_payment, :pf, :tds_pm, :total_Earnings, :professional_tax, :medical_insurances_total, :savings_total, :claimed_medical_bill, :rent_paid, :rent_received, :final_hra_component, :tax_paid, :surcharge, :existed_payslips_count, :balance_tax_per_remaining_months_each, :count_of_payslips_to_create_in_the_year])
  end
  
end
