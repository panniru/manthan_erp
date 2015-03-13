module Payroll
  class SalaryTaxCreationService
    
    class << self
      def new_salary_tax(employee, fin_year_from, fin_year_to)
        salary_tax = SalaryTax.new do |tax|
          tax.financial_year_from = fin_year_from
          tax.financial_year_to = fin_year_to
          tax.faculty_master = employee
          tax.medical_insurances << MedicalInsurance.new
          tax.medical_bills << MedicalBill.new
          tax.savings << Saving.new
        end
      end
    end

    def initialize(faculty_master, params, fin_year_from, fin_year_to)
      @faculty_master = faculty_master
      @salary_tax_params = params
      @fin_year_from = fin_year_from
      @fin_year_to = fin_year_to
    end

    def update(salary_tax)
      ActiveRecord::Base.transaction do
        begin
          if salary_tax.update_attributes(salary_tax_params)
            save_medicall_bills(salary_tax)
            save_medicall_insurances(salary_tax)
            save_savings(salary_tax)
          else
            raise ActiveRecord::Rollback
            return false
          end
        rescue Exception => e
          raise ActiveRecord::Rollback
          return false
        end
      end
      true
    end

    def create
      salary_tax = nil
      ActiveRecord::Base.transaction do
        begin
          salary_tax = SalaryTax.new(salary_tax_params)
          salary_tax.financial_year_from = @fin_year_from
          salary_tax.financial_year_to = @fin_year_to
          if salary_tax.save!
            save_medicall_bills(salary_tax)
            save_medicall_insurances(salary_tax)
            save_savings(salary_tax)
          else
            raise ActiveRecord::Rollback
            return nil
          end
        rescue Exception => e
          raise ActiveRecord::Rollback
          return nil
        end
      end
      salary_tax
    end

    def save_medicall_bills(salary_tax)
      bills = []
      @salary_tax_params[:medical_bills].each do |m_b_params|
        if m_b_params[:id].present?
          medical_bill = MedicalBill.find(m_b_params[:id])
          medical_bill.assign_attributes(medicall_bill_params(m_b_params))
          bills << medical_bill
        else
          if m_b_params[:amount].present?
            bills << MedicalBill.new(medicall_bill_params(m_b_params)) do |bill|
              bill.faculty_master = @faculty_master
              bill.salary_tax = salary_tax
            end
          end
        end
      end
      if bills.map(&:valid?).all?
        bills.map(&:save)
      else
        raise ActiveRecord::Rollback
        return false
      end
      true
    end

    def save_medicall_insurances(salary_tax)
      insurances = []
      @salary_tax_params[:medical_insurances].each do |m_i_params|
        if m_i_params[:id].present?
          medical_insurance = MedicalInsurance.find(m_i_params[:id])
          medical_insurance.assign_attributes(medicall_insurance_params(m_i_params))
          insurances << medical_insurance
        else
          ins = MedicalInsurance.new(medicall_insurance_params(m_i_params)) do |insurance|
            insurance.faculty_master = @faculty_master
            insurance.salary_tax = salary_tax
          end
          insurances << ins  if m_i_params[:amount].present?
        end
      end
      if insurances.map(&:valid?).all?
        insurances.map(&:save)
      else
        raise ActiveRecord::Rollback
        return false
      end
      true
    end

    def save_savings(salary_tax)
      savings = []
      @salary_tax_params[:savings].each do |s_params|
        if s_params[:id].present?
          saving = Saving.find(s_params[:id])
          saving.assign_attributes(saving_params(s_params))
          savings<< saving
        else
          savings << Saving.new(saving_params(s_params)) do |saving|
            saving.faculty_master = @faculty_master
            saving.salary_tax = salary_tax
          end if s_params[:amount].present?
        end
      end
      if savings.map(&:valid?).all?
        savings.map(&:save)
      else
        raise ActiveRecord::Rollback
        return false
      end
      true
    end

    
    def salary_tax_params
      @salary_tax_params.permit(:faculty_master_id, :rent_per_month, :rent_receipt, :standard_deduction, :rent_received_per_month, :other_tax, :atg, :pt_and_wt, :employee_home_loan_interest, :occupancy_type)
    end

    def medicall_bill_params(params)
      params.permit(:faculty_master_id, :salary_tax_id, :amount, :bill_no, :bill_date)
    end

    def medicall_insurance_params(params)
      params.permit(:faculty_master_id, :salary_tax_id, :amount, :bill_no, :bill_date, :parent_included, :parent_senior_citizen)
    end

    def saving_params(params)
      params.permit(:faculty_master_id, :salary_tax_id, :saving_type, :amount, :bill_no, :bill_date)
    end
  end
end
