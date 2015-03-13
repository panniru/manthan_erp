class PayslipMailingJob

  def initialize(scrolled_by, month, year, date)
    @scrolled_by = scrolled_by
    @date = date
    @month = month
    @year = year
    @job_run_id = JobRun.schedule("payslip_mailing",  scrolled_by, date).id
  end

  def perform
    Payslip.approved.in_the_month(@month).in_the_year(@year).each do |payslip|
      PayslipMailer.payslip(payslip).deliver if payslip.faculty_master.email.present?
    end
  end
  
  def success(job)
    JobRun.finish_as_success(@job_run_id)
  end

  def error(job, error)
    JobRun.finish_as_error(@job_run_id)
  end

  def failure(job)
    JobRun.finish_as_failed(@job_run_id)
  end

  def job_run_id
    @job_run_id
  end
  
end
