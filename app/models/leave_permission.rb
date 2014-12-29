class LeavePermission < ActiveRecord::Base

  belongs_to :faculty_master
  def self.get_dates
    data = LeavePermission.where(":today >= from_date AND :today <= to_date", today: Date.today)
  end
  
  def self.get_leaves
    holidays = Holidaycalendar.uniq.pluck(:holiday_date)
    values = (Date.today..Date.today + 1.year).to_a.select {|k| [6,0].include?(k.wday)} + holidays

  end

  
  def self.get_type_of_leave(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = FacultyAttendance.select('type_of_leave').where(:faculty_master_id => current_user_id).map {|map| map.type_of_leave }
    return type_of_leave[0]
  end
  
 
  def self.get_casual_leave_count(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = FacultyAttendance.select('pending_casual_leave').where(:faculty_master_id => current_user_id).map {|map| map.pending_casual_leave }
    return type_of_leave[0]
  end
  
  def self.get_sick_leave_count(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = FacultyAttendance.select('pending_sick_leave').where(:faculty_master_id => current_user_id).map {|map| map.pending_sick_leave}
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
      {faculty_master_id: map.faculty_master_id, from_date: map.from_date, to_date: map.to_date, type_of_leave: map.type_of_leave,  status: map.status, reason: map.reason, name: map.faculty_master.faculty_name}
    end
    return type_of_leave
  end


  

end
