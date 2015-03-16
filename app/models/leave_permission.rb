class LeavePermission < ActiveRecord::Base

  belongs_to :faculty_master

    
  
  
  def self.get_casual_leave(current_user)
    if
        if LeavePermission.exists?(&:max_casual_leave) && LeavePermission.where.not(casual_leave_count: nil) && LeavePermission.where(:casual_leave_count != '')
         lp = LeavePermission.minimum(:casual_leave_count)
       else
         lp = LeavePermission.maximum(:max_casual_leave)
       end
      return lp.to_f
    else
      current_user_id = "#{current_user.faculty_master.id}"
      get_faculty_designation = FacultyMaster.select('designation').where(:id => current_user_id).map {|user| user.designation}
      get_max_casual_leave = SetupMaster.select('casual_leave').where(:designation => get_faculty_designation).map {|max_leave| max_leave.casual_leave}
      return get_max_casual_leave[0]
    end
  end

  def self.get_sick_leave(current_user)
    if 
        if LeavePermission.exists?(&:max_sick_leave) && LeavePermission.where.not(sick_leave_count: nil) && LeavePermission.where(:sick_leave_count != '')
      lp = LeavePermission.minimum(:sick_leave_count)
        else
          lp = LeavePermission.maximum(:max_sick_leave)
        end
      return lp.to_f
  else
      current_user_id = "#{current_user.faculty_master.id}"
      get_faculty_designation = FacultyMaster.select('designation').where(:id => current_user_id).map {|user| user.designation}
      get_max_sick_leave = SetupMaster.select('sick_leave').where(:designation => get_faculty_designation).map {|max_leave| max_leave.sick_leave}
      return get_max_sick_leave[0]
    end  
  end


  def self.get_leaves(current_user, a, b, from_day, to_day)
    current_user_id = "#{current_user.faculty_master.id}"
    c = Date.parse(a).strftime("%Y-%m-%d")
    d = Date.parse(b).strftime("%Y-%m-%d")
    e = c, d
    final_date = ((c..d).to_a) - (e.to_a) 
    holidays = Holidaycalendar.uniq.pluck(:holiday_date)
    values = (Date.today..Date.today + 1.year).to_a.select {|k| [6,0].include?(k.wday)} + holidays
    year_holidays =values.map{|x| x.strftime("%Y-%m-%d")}
    answer = (final_date - year_holidays).count
    p "@@@@@@@@@@@@@@@@@@@@@@@@"
    p answer
    p from_day
    p to_day
    p answer-from_day-to_day
    return answer+from_day+to_day
    
  end
 
 

  def self.get_dates
    data = LeavePermission.where(":today >= from_date AND :today <= to_date", today: Date.today)
  end
  
     
  def self.get_type_of_leave(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = FacultyAttendance.select('type_of_leave').where(:faculty_master_id => current_user_id).map {|map| map.type_of_leave }
    return type_of_leave[0]
  end
  
 

  def self.get_faculty_attendance_id(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = FacultyAttendance.select('faculty_master_id').where(:faculty_master_id => current_user_id).map {|map| map.faculty_master_id }
    return type_of_leave[0]
  end

  def self.get_details(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = LeavePermission.select('faculty_master_id','from_date','to_date','reason','type_of_leave','status').where(:faculty_master_id => current_user_id).map do |map| 
      {faculty_master_id: map.faculty_master_id, from_date: map.from_date, to_date: map.to_date, type_of_leave: map.type_of_leave,  status: map.status, reason: map.reason, name: map.faculty_master.faculty_name }
    end
    return type_of_leave
  end

  

end
