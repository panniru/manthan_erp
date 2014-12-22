class FacultyAttendance < ActiveRecord::Base

  

  scope :on_date, lambda { |date| where("attendance_date = ? ", date)}
  scope :on_designation, lambda { |designation| where("designation = ? ", designation)}
  scope :get_type_of_leave, lambda { |type_of_leave| where("type_of_leave = ? ", type_of_leave)}
  

  def self.get_faculty_details(current_user, type_of_leave)
    if(FacultyMaster.where('id ='+"#{current_user.id}").length != 0)
      current_user_id = "#{current_user.id}"
      get_faculty = FacultyAttendance.get_type_of_leave(type_of_leave).where(:faculty_master_id => current_user_id, :type_of_leave => type_of_leave).select(%q{faculty_master_id,max_casual_leave, max_sick_leave, pending_casual_leave, pending_sick_leave, type_of_leave}).group('type_of_leave','max_casual_leave', 'max_sick_leave', 'pending_casual_leave', 'pending_sick_leave','faculty_master_id')
    end
    get_faculty
  end


  def get_casual_leave(designation)
    a = designation
    form = SetupMaster.select('casual_leave').where(:designation => a).map {|designation| designation.casual_leave}
    return form[0]
  end

  def get_sick_leave(designation)
    a = designation
    form = SetupMaster.select('sick_leave').where(:designation => a).map {|designation| designation.sick_leave}
    return form[0]
  end

  def get_pending_casual_leave(designation)
    count_no = FacultyAttendance.where(:designation => designation,:type_of_leave => 'casual leave').select(%q{faculty_master_id, name, max_casual_leave - sum(case when forenoon = 'A' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'A' then 1 else 0 end + case when forenoon = 'P' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'L' then 1 else 0 end +  case when forenoon = 'P'  and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'L' then 1 else 0 end + case when forenoon = 'L' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'A' then 1 else 0 end ) as pending_casual_leave }).group('faculty_master_id','name','max_casual_leave').map {|d| d.pending_casual_leave}
    return count_no[0]
  end

  def get_pending_sick_leave(designation)
    count_no = FacultyAttendance.where(:designation => designation,:type_of_leave => 'sick leave').select(%q{faculty_master_id, name, max_sick_leave - sum(case when forenoon = 'A' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'A' then 1 else 0 end + case when forenoon = 'P' and afternoon = 'A' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = '' then 0.5 else 0 end + case when forenoon = '' and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'L' then 1 else 0 end +  case when forenoon = 'P'  and afternoon = 'L' then 0.5 else 0 end + case when forenoon = 'A' and afternoon = 'L' then 1 else 0 end + case when forenoon = 'L' and afternoon = 'P' then 0.5 else 0 end + case when forenoon = 'L' and afternoon = 'A' then 1 else 0 end ) as pending_sick_leave }).group('faculty_master_id','name','max_sick_leave').map {|d| d.pending_sick_leave}
    return count_no[0]
  end



  def self.get_faculty_names
    results = []
    results = FacultyMaster.all.group_by(&:designation)
  end

  def self.get_faculty_design(designation)
    results = FacultyAttendance.on_designation(designation)
    data = []
    if results.count > 0
      data = results.map do |result|
        {name: result.name,faculty_master_id: result.faculty_master_id,designation: designation, forenoon: result.forenoon, attendance_date: result.attendance_date, afternoon: result.afternoon, id: result.id, type_of_leave: result.type_of_leave, pending_casual_leave: result.get_pending_casual_leave(designation), pending_sick_leave: result.pending_sick_leave,max_casual_leave: result.get_casual_leave(designation), max_sick_leave: result.get_sick_leave(designation)}
      end
    else
      res = FacultyMaster.show_all_faculties(designation)
      p res
      if res.present?
        data = res.map do |res|
          {designation: designation, forenoon: "", afternoon: "",name: res.faculty_name, attendance_date: "",faculty_master_id: res.id, max_sick_leave: res.get_sick_leave(designation),max_casual_leave: res.get_casual_leave(designation),type_of_leave:"",pending_casual_leave: res.get_pending_casual_leave(designation),pending_sick_leave: res.get_pending_sick_leave(designation)}
        end
      end
    end
  end

end
 
