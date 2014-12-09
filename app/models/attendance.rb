class Attendance < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :faculty_master
  
  scope :this_weekend, lambda { where(:attendance_date => (Date.today.at_beginning_of_week..Date.today.at_end_of_week))}
  scope :active_at_date, lambda { where("attendance_date < :date and attendance_date > :date", date: Date.today )}
  scope :belongs_to_month, lambda{|month| where("to_char(attendance_date, 'FMMM') = ?", month.to_s)}
  scope :on_date, lambda { |date| where("attendance_date = ? ", date)}
  scope :taken_by_faculty, lambda { |faculty_master_id| where("faculty_master_id = ? ", faculty_master_id)}
  
  def self.this_month(month)
    grouping_month = Attendance.find_by_sql( " SELECT student_master_id,name ,sum(case when attendance = 'P' then 1 else 0 end) as Present, sum(case when attendance = 'A' then 1 else 0 end) as Absent, sum(case when attendance = 'L' then 1 else 0 end) as Leave from attendances where attendance_date >= (now() - interval '1 month') group by student_master_id,name;")
  end
  def self.get_month(month, faculty)
   p month
    attendances = Attendance.this_month(month)
    p attendances
    data = []
    data = attendances.map do |res|
      {name: res.name, present: res.present, absent: res.absent, leave: res.leave}
    end
  end
  
  #--------------------Grouping Month
  def self.grouping_month(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      grouping_month  = Attendance.where(:faculty_master_id => current_user_id)
      get_details = grouping_month.find_by_sql("SELECT (TO_CHAR(attendance_date, 'Month')  || EXTRACT(year from attendance_date)) as month, student_master_id, name,sum(case when attendance = 'P' then 1 else 0 end) as Present, sum(case when attendance = 'A' then 1 else 0 end) as Absent, sum(case when attendance = 'L' then 1 else 0 end) as Leave FROM attendances GROUP BY month,student_master_id,name;")
    end
    data = []
    data = get_details.group_by(&:month)
      
    data.each do |key, val|
      inner_data = {}
      
      val.each do |val|
        inner_data[:present] = val.present
        inner_data[:absent] = val.absent
        inner_data[:leave] = val.leave
      end
      inner_data.to_h
    end
  end
  
  #----------To get No of Working Days for current Month
  def self.get_working_days(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      show_attendance_date  = Attendance.where(:faculty_master_id => current_user_id,:attendance_date => (Date.today.at_beginning_of_month..Date.today.at_end_of_month))
      working_days = show_attendance_date.distinct.count('attendance_date')
    end
    return working_days
  end

  
  #------------------Weekly Attendance
  def self.this_week(date, current_user)
    if(ClassTeacherMapping.where('faculty_master_id = '+"#{current_user.id}").length != 0)
      current_user_id="#{current_user.id}"
      show_attendance_date = []
      show_attendance_date  = Attendance.select('attendance','student_master_id','attendance_date').where(:faculty_master_id => current_user_id).this_weekend.order('attendance_date ASC')
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
      present = show_attendance_date.find_by_sql "SELECT name , student_master_id, sum(case when attendance = 'P' then 1 else 0 end) as Present, sum(case when attendance = 'A' then 1 else 0 end) as Absent, sum(case when attendance = 'L' then 1 else 0 end) as Leave from attendances where attendance_date >= (now() - interval '1 month') group by  student_master_id, name;"
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
  
