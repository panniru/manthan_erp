class PfStatementGenerator
  
  def initialize(scrolled_by, date)
    @scrolled_by = scrolled_by
    @date = date
    @month = date.strftime("%b")
    @year = date.strftime("%Y")
    @job_run_id = JobRun.schedule("pf_statement_mailing", scrolled_by, date).id
  end
  
  def perform
    ActiveRecord::Base.transaction do
      begin
        status = Payslip.in_the_month(@month).in_the_year(@year).approved.map do |payslip|
          pf_statement = Payroll::FacultyNewPfStatement.new(payslip).pf_statement
          pf_statement.job_run_id = @job_run_id
          pf_statement.payslip_id = payslip.id
          pf_statement.save
        end
        unless status.all?
          raise ActiveRecord::Rollback
          return false
        end
      end
    end
    return true
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
