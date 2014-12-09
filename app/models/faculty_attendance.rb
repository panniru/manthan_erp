class FacultyAttendance < ActiveRecord::Base

  scope :on_designation, lambda { |designation| where("designation = ? ", designation)}

  def self.get_faculty_names
    results = []
    results = FacultyMaster.all.group_by(&:designation)
       
  end

  def self.get_faculty_design(designation)
    results = FacultyAttendance.on_designation(designation)
    data = []
    if results.count > 0
      data = results.map do |result|
        {name: result.name,id: result.id,designation: designation, forenoon: result.forenoon, attendance_date: result.attendance_date}
      end
    else
      res = FacultyMaster.show_all_faculties(designation)
      p res
      if res.present?
        data = res.map do |res|
          {designation: designation, forenoon: "", name: res.faculty_name, attendance_date: "",id: res.id}
        end
      end
    end
  end

end
 
