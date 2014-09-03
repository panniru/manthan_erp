class TermResultMailingJob 
  def initialize(scrolled_by, date)   
    @scrolled_by = scrolled_by
    @job_run_id = JobRun.schedule("term_result_mailing", scrolled_by, date).id   
  end 
  
  def job_run_id
    @job_run_id
  end
  
  def perform   
    
  end

  def make_failure_entry(email, remarks, faculty)
    TermResultFailure.create(:e_mail => email, :job_run_id => @job_run_id, :faculty_master_id => faculty.id, :remarks => remarks)
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
