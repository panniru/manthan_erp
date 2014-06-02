class FeeStructMailingJob

  def initialize(scrolled_by, date)
    @scrolled_by = scrolled_by
    @job_run_id = JobRun.schedule("fee_structure_mailing", scrolled_by, date).id
  end

  def perform
    grade_fee_grid = GradeFeeGrid.new
    term_fee_grid = TermFeeGrid.new
    monthly_pdc_grid = MonthlyPdcGrid.new
    
    Parent.all.each do |parent|
      applied_grade_bucket_ids = []
      emails = []
      parent.students.each do |student|
        applied_grade_bucket_ids << FeeGradeBucket.find_grade_bucket_by_grade(student.grade).id
        emails << parent.father_email if parent.father_email.present?
        emails << parent.mother_email if parent.mother_email.present?
        emails << parent.guardian_email if parent.guardian_email.present?
      end
      FeeAlertsMailer.fee_structure_mail(grade_fee_grid, term_fee_grid, monthly_pdc_grid, applied_grade_bucket_ids, parent, emails).deliver
      puts "Excecuting Delayed job........"
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
  
end
