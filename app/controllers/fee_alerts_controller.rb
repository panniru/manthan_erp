class FeeAlertsController < ApplicationController
  
  def fee_struct_mail_to_parents
    respond_to do |format|
      mailing_job = FeeStructMailingJob.new(current_user.user_id, DateTime.now)
      Delayed::Job.enqueue mailing_job mailing_job.job_run_id
      result_link = "<a href=\"/job_runs/#{22}\">here</a>"
      msg = I18n.t :success, :scope => [:job, :schedule], job: "Fee Structure Mailing Job", result_link: result_link
      format.json do
        render :json => msg
      end
      format.html do
        flash[:success] = msg.html_safe
        redirect_to grade_wise_fees_path
      end
    end
  end
  
end
