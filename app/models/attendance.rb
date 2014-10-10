class Attendance < ActiveRecord::Base
  belongs_to :student_master
  scope :active_at_date, lambda { where("attendance_date < :date and attendance_date > :date", date: Date.today )}
  scope :belongs_to_month, lambda{|month| where("to_char(attendance_date, 'FMMM') = ?", month.to_s)}
  scope :on_date, lambda { |date| where("attendance_date = ? ", date)}
  scope :taken_by_faculty, lambda { |faculty_master_id| where("faculty_master_id = ? ", faculty_master_id)}

  def self.student_summarized_monthly_report(student_id)
    present_query = "SELECT to_char(attendance_date, 'month') gmonth, count(*) present, 0 absent, 0 leave  from attendances where attendance = 'P' and student_master_id = "+student_id.to_s+"group by gmonth"
    absent_query = "SELECT to_char(attendance_date, 'month') gmonth, 0 present, count(*)  absent, 0 leave  from attendances where attendance = 'A' and student_master_id = "+student_id.to_s+"group by gmonth"
    leave_query = "SELECT to_char(attendance_date, 'month') gmonth, 0 present, 0 absent, count(*) leave  from attendances where attendance = 'L' and student_master_id = "+student_id.to_s+"group by gmonth"
    combined_query = "SELECT initcap(R1.gmonth) gmonth, sum(R1.present) present, sum(R1.absent) absent, sum(R1.leave) leave from( "+present_query+" UNION "+absent_query+" UNION "+leave_query+" ) AS R1 GROUP BY R1.gmonth ORDER BY to_date(gmonth, 'Mon')"
    ActiveRecord::Base.connection.execute(combined_query)
  end


end
  
