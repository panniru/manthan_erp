module Payroll
  class PayslipCreationService
    class << self
      def new_payslip_attributes_for_employees(employees, date)
        employees.map do |emp|
          payslip = Payroll::FacultyNewPayslip.new(emp, date).payslip
          payslip.attributes.merge!({faculty_master_code: emp.code, faculty_master_name: emp.faculty_name}).except(:created_at, :updated_at)
          # irregular_allowances = {
          #   :is_eligible_for_loyality_allowance => emp.eligible_for_loyality_allowance?(date),
          #   :is_eligible_for_leave_settlement => emp.eligible_for_leave_settlement?(date),
          #   :is_eligible_for_annual_bonus_payment => emp.eligible_for_annual_bonus_payment?(date)
          # } 
          # payslip.attributes.merge!(irregular_allowances)
        end
      end

      def create_payslips(params)
        payslips = params.map do |param|
          Payslip.new(payslip_params(param))
        end
        ActiveRecord::Base.transaction do
          begin
            if payslips.map(&:valid?).all?
              payslips.each do |p|
                p.mark_as_pending
                p.save
                p.post_payslip_creation_actions
              end
              return true
            else
              return false
            end
          # rescue Exception => e
          #   raise ActiveRecord::Rollback
          #  return false
          end
        end
        true
      end

      def payslip_params(params)
        params.permit(:faculty_master_id, :generated_date, :basic, :hra, :conveyance_allowance, :city_compensatory_allowance, :special_allowance, :loyalty_allowance, :medical_allowance, :arrears_of_salary, :incentive_payment, :loyalty_deposit, :grade_allowance, :leave_settlement, :performance_bonus, :additional_allowance_1, :additional_allowance_2, :additional_allowance_3, :pf, :club_contribution, :professional_tax, :tds_pm, :training_cost, :salary_advance, :voluntary_pf_contribution, :labour_welfare_fund,:additional_deduction_1, :additional_deduction_2, :additional_deduction_3, :status, :notice_period_amount, :additional_allowance_1_label, :additional_allowance_2_label, :additional_allowance_3_label, :additional_deduction_1_label, :additional_deduction_2_label, :additional_deduction_3_label)
      end
    end
  end
end
