class Attendance < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :faculty_master
    
  scope :this_weekend, lambda { where(:attendance_date => (Date.today.at_beginning_of_week..Date.today.at_end_of_week))}
  scope :active_at_date, lambda { where("attendance_date < :date and attendance_date > :date", date: Date.today )}
  scope :belongs_to_month, lambda{|month| where("to_char(attendance_date, 'FMMM') = ?", month.to_s)}
  scope :on_date, lambda { |date| where("attendance_date = ? ", date)}
  scope :taken_by_faculty, lambda { |faculty_master_id| where("faculty_master_id = ? ", faculty_master_id)}


  #----------To get No of Working Days for current Month
  def self.get_working_days(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      show_attendance_date  = Attendance.where(:faculty_master_id => current_user_id)
      a = show_attendance_date.distinct.count('attendance_date')
      return a 
    end
  end


  #------------------Weekly Attendance
  def self.this_week(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      show_attendance_date = []
      show_attendance_date  = Attendance.where(:faculty_master_id => current_user_id).this_weekend
    end
    data = []
    data = show_attendance_date.group_by(&:student_master_id)
    data.map do |key, val|
      inner_data = {}
      inner_data[:Name] = StudentMaster.find(key).name
      val.each do |val|
        inner_data[val.attendance_date] = val.attendance
      end
      inner_data.to_h
    end
  end


  #------------------------------Monthly Attendance
  def self.attendance_details(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      show_attendance_date = []
      show_attendance_date  = Attendance.where(:faculty_master_id => current_user_id)
      present = Attendance.find_by_sql "SELECT name , student_master_id, sum(case when attendance = 'P' then 1 else 0 end) as Present, sum(case when attendance = 'A' then 1 else 0 end) as Absent, sum(case when attendance = 'L' then 1 else 0 end) as Leave from attendances where attendance_date >= (now() - interval '1 month') group by  student_master_id, name;"
    end
  end
  
  
  #-----------------------------To get dates of current Week
  def self.thisweek
    week = (Date.today.at_beginning_of_week..Date.today.at_end_of_week)
    return week
    p week
  end

  def self.student_summarized_monthly_report(student_id)
    present_query = "SELECT to_char(attendance_date, 'month') gmonth, count(*) present, 0 absent, 0 leave  from attendances where attendance = 'P' and student_master_id = "+student_id.to_s+"group by gmonth"
    absent_query = "SELECT to_char(attendance_date, 'month') gmonth, 0 present, count(*)  absent, 0 leave  from attendances where attendance = 'A' and student_master_id = "+student_id.to_s+"group by gmonth"
    leave_query = "SELECT to_char(attendance_date, 'month') gmonth, 0 present, 0 absent, count(*) leave  from attendances where attendance = 'L' and student_master_id = "+student_id.to_s+"group by gmonth"
    combined_query = "SELECT initcap(R1.gmonth) gmonth, sum(R1.present) present, sum(R1.absent) absent, sum(R1.leave) leave from( "+present_query+" UNION "+absent_query+" UNION "+leave_query+" ) AS R1 GROUP BY R1.gmonth ORDER BY to_date(gmonth, 'Mon')"
    ActiveRecord::Base.connection.execute(combined_query)
  end


end
  
