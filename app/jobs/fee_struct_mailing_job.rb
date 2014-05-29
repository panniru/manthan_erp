class FeeStructMailingJob

  def initialize(scrolled_by, date)
    @scrolled_by = scrolled_by
    @job_run_id = JobRun.schedule("fee_structure_mailing", scrolled_by, date).id
  end

  def perform
    puts "Excecuting Delayed job........"
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
  
end
