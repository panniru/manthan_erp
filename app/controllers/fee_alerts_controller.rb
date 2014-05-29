class FeeAlertsController < ApplicationController
  

  def fee_struct_mail_to_parents
    mailing_job = FeeStructMailingJob.new(current_user.user_id, DateTime.now)
    Delayed::Job.enqueue mailing_job
  end
  
end
