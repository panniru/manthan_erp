class FeeAlertsMailer < ActionMailer::Base
  default :css => 'email'
  
  def welcome_email
    @to  = 'srikanth@ostryalabs1.com'
    mail(to: @to, subject: 'Welcome to My Awesome Site')
  end

  def fee_structure_mail(anual_grade_fees, term_grade_fees, month_grade_fees, grades, parent, emails)
    @anual_grade_fees = anual_grade_fees.grid_belongs_to_grades(grades)
    @term_grade_fees = term_grade_fees.grid_belongs_to_grades(grades)
    @month_grade_fees = month_grade_fees.grid_belongs_to_grades(grades)
    @fee_types = anual_grade_fees.grid_headers
    @grades = anual_grade_fees.grid_grade_buckets
    @terms = term_grade_fees.grid_headers
    @months = month_grade_fees.grid_headers
    mail(to: emails.join(","), subject: 'Fee details')
  end
  
end
