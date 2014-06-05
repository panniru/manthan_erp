class JobRun < ActiveRecord::Base
  belongs_to :job
  
  def self.schedule(job_code, scrolled_by, job_date)
    job = Job.find_by_code(job_code)
    run = JobRun.new(job_id: job.id, scrolled_by: scrolled_by, started_on: DateTime.now, status: "scheduled", job_date: job_date)
    yield run if block_given?
    run.save
    run
  end
  
  def self.finish_as_success(job_run_id)
    finish_as(job_run_id, 'success')
  end

  def self.finish_as_error(job_run_id)
    finish_as(job_run_id, 'error')
  end
  
  def self.finish_as_failed(job_run_id)
    finish_as(job_run_id, 'failed')
  end

  def self.finish_as(job_run_id, status)
    job_run = JobRun.find(job_run_id)
    job_run.finish_run_as(status)
  end
  
  def finish_run_as(status)
    update_attributes(status: status, finished_on: DateTime.now)
  end

end
