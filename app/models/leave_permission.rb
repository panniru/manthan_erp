class LeavePermission < ActiveRecord::Base

  belongs_to :faculty_master
  scope :get_typ_of_leave, lambda { |type_of_leave| where("type_of_leave = ? ", type_of_leave)}
  scope :not_null_method, -> { where.not(:max_casual_leave => nil) }
  scope :faculty_master_id_not_null, -> { where.not(:faculty_master_id => nil) }
  scope :all_null_method, -> { where(:faculty_master_id => nil, :casual_leave_count => nil, :sick_leave_count => nil, :loss_of_pay_count => nil) }


  def self.initial_count(current_user)
    data = []
    s_data = LeavePermission.all_null_method
    data = s_data.group_by(&:faculty_master_id)
    data.map do |key, val|
      inner_data = {}
      # inner_data[:Name] = FacultyMaster.find(key).faculty_name
      val.each do |val|
        if val.type_of_leave == 'Casual Leave'
          inner_data[val.type_of_leave] = val.get_casual_of_leaves_count(current_user)
        end
        if val.type_of_leave == 'Sick Leave'
          inner_data[val.type_of_leave] = val.get_sick_of_leaves_count(current_user)
        end
        if val.type_of_leave == 'Loss of Pay'
          inner_data[val.type_of_leave] = val.get_loss_of_leaves_count(current_user)
        end
      end
      inner_data.to_h
    end
  end
  def self.this_test(current_user)
    data = []
    s_data = LeavePermission.faculty_master_id_not_null
    data = s_data.group_by(&:faculty_master_id)
    data.map do |key, val|
      inner_data = {}
      # inner_data[:Name] = FacultyMaster.find(key).faculty_name
      val.each do |val|
        if val.type_of_leave == 'Casual Leave'
          inner_data[val.type_of_leave] = val.get_casual_of_leaves_count(current_user)
        end
        if val.type_of_leave == 'Sick Leave'
          inner_data[val.type_of_leave] = val.get_sick_of_leaves_count(current_user)
        end
        if val.type_of_leave == 'Loss of Pay'
          inner_data[val.type_of_leave] = val.get_loss_of_leaves_count(current_user)
        end
      end
      inner_data.to_h
    end
  end


  def self.get_faculty_details(current_user, type_of_leave)
    get_leave = LeavePermission.get_typ_of_leave(type_of_leave)
    get_c = LeavePermission.minimum(:max_casual_leave)
    get_s = LeavePermission.minimum(:max_sick_leave)
    if get_c == '0.0' && get_s == '0.0'
      take_value = LeavePermission.select(%q{faculty_master_id,min(max_casual_leave) as c_count,min(max_sick_leave) as s_count, sum(loss_of_pay_count),type_of_leave}).all_null_method.group('type_of_leave','faculty_master_id').distinct(:type_of_leave)
    end
    
    if get_c != '0.0' && get_s == '0.0'
      take_value = LeavePermission.select(%q{faculty_master_id,min(casual_leave_count) as c_count,min(sick_leave_count) as s_count,sum(loss_of_pay_count), type_of_leave}).all_null_method.group('type_of_leave','faculty_master_id').distinct(:type_of_leave)    
            
    end

    if get_c != '0.0' && get_s != '0.0'
      take_value = LeavePermission.select(%q{faculty_master_id,min(casual_leave_count) as c_count,min(sick_leave_count) as s_count,sum(loss_of_pay_count), type_of_leave}).all_null_method.group('type_of_leave','faculty_master_id').distinct(:type_of_leave)
    end
  end


  def get_casual_of_leaves_count(current_user)
    get_c = LeavePermission.minimum(:max_casual_leave)
    get_cc = LeavePermission.minimum(:casual_leave_count)
    if get_c == '0.0' || get_c.to_f >= get_cc.to_f
      take_value = LeavePermission.select('casual_leave_count').minimum(:casual_leave_count)
    else
      take_value = LeavePermission.select('max_casual_leave').minimum(:max_casual_leave)
    end
    return take_value.to_f
  end

  def get_sick_of_leaves_count(current_user)
    get_c = LeavePermission.minimum(:max_sick_leave)
    get_cc = LeavePermission.minimum(:sick_leave_count)
    if get_c == '0.0' || get_c.to_f >= get_cc.to_f
      take_value = LeavePermission.select('sick_leave_count').minimum(:sick_leave_count)
    else
      take_value = LeavePermission.select('max_sick_leave').minimum(:max_sick_leave)
    end
    return take_value.to_f
  end
 

  def get_loss_of_leaves_count(current_user)
    get_c = LeavePermission.sum(:loss_of_pay_count)
    return get_c
  end

  
  
  def self.get_casual_leave(current_user)
    p "1111111111111111111111111"
    p current_user.user_id 
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
    type_of_leave = FacultyMaster.select('id').where(:id => current_user_id).map {|map| map.id }
    return type_of_leave[0]
  end

  def self.get_details(current_user)
    current_user_id = "#{current_user.faculty_master.id}"
    type_of_leave = LeavePermission.select('faculty_master_id','from_date','to_date','reason','type_of_leave','status').where(:faculty_master_id => current_user_id).not_null_method.map do |map| 
      {faculty_master_id: map.faculty_master_id, from_date: map.from_date, to_date: map.to_date, type_of_leave: map.type_of_leave,  status: map.status, reason: map.reason, name: map.faculty_master.faculty_name }
    end
    return type_of_leave
  end

  

end
