class FeeAlertsMailer < ActionMailer::Base
  default :css => 'email'

  
  def welcome_email(to)
    mail(to: to, subject: 'Welcome to My Awesome Site')
  end
  
  
  def fee_structure_mail(anual_grade_fees, term_grade_fees, month_grade_fees, parent, emails)
    generate_view_instances(anual_grade_fees, term_grade_fees, month_grade_fees)
    mail(to: emails.join(","), subject: 'Fee details')
  end

  def approve_mail(anual_grade_fees, term_grade_fees, month_grade_fees,sender, reciever)
    generate_view_instances(anual_grade_fees, term_grade_fees, month_grade_fees)
    @reciever = reciever
    #mail(to: reciever.email, subject: 'Fee Structure Approval')
    mail(to: "srikanth@ostryalabs.com", subject: 'Fee structure approval')
  end

  def rejected_mail(anual_grade_fees, term_grade_fees, month_grade_fees, sender, reciever)
    generate_view_instances(anual_grade_fees, term_grade_fees, month_grade_fees)
    @reciever = reciever
    #mail(to: reciever.email, subject: 'Fee Structure Rejected')
    mail(to: "srikanth@ostryalabs.com", subject: 'Fee structure rejected')
  end

  def approved_mail(anual_grade_fees, term_grade_fees, month_grade_fees,sender, reciever)
    generate_view_instances(anual_grade_fees, term_grade_fees, month_grade_fees)
    @reciever = reciever
    #mail(to: reciever.email, subject: 'Fee Structure Approval')
    mail(to: "srikanth@ostryalabs.com", subject: 'Fee structure has been approved')
  end


  private
  def generate_view_instances(anual_grade_fees, term_grade_fees, month_grade_fees)
    @anual_grade_fees = anual_grade_fees.get_grid
    @term_grade_fees = term_grade_fees.get_grid
    @month_grade_fees = month_grade_fees.get_grid
    @fee_types = anual_grade_fees.grid_headers
    @grades = anual_grade_fees.grid_grade_buckets
    @terms = term_grade_fees.grid_headers
    @months = month_grade_fees.grid_headers
  end

  
end
