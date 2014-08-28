class SpecialRouteMailingJob

  def initialize(scrolled_by, date)
    @scrolled_by = scrolled_by
    @job_run_id = JobRun.schedule("special_route_mailing", scrolled_by, date).id
  end

  def job_run_id
    @job_run_id
  end
  
  def perform
    @email_id_map = {}
    StudentMaster.where(:bus_facility => true).each do |student|
      @email_id_map[student.parent.father_email] = student.parent.id if student.parent.father_email.present?
      @email_id_map[student.parent.mother_email] = student.parent.id if student.parent.mother_email.present?
      @email_id_map[student.parent.guardian_email] = student.parent.id if student.parent.guardian_email.present?
    end
    begin
      @email_id_map.keys.each
      UserMailer.special(@email_id_map.keys).deliver
    rescue Exception => m
      @email_id_map.keys.each do |mail|
        begin
          UserMailer.special(@email_id_map.keys).deliver
        rescue Exception => em
          make_failure_entry(mail, em.message, @email_id_map[mail])
        end
      end
    end
  end
  
  def make_failure_entry(email, remarks, parent)
    FeeAlertFailure.create(:e_mail => email, :job_run_id => @job_run_id, :parent_id => parent.id, :remarks => remarks)
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
