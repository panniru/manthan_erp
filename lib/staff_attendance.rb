module StaffAttendance
  class FacultyAttendan
    def initialize(std)
      @student = std
    end


    def self.attendance_on_date(date, designation)
      p designation
      results = FacultyAttendance.on_designation(designation).on_date(date)
      data = []
      if results.count > 0
        data = results.map do |result|
          {name: result.name, designation: designation,faculty_master_id: result.faculty_master_id, forenoon: result.forenoon, attendance_date: date}
        end
      else
        res = FacultyMaster.on_designation(designation)
        p res
        p designation
        if res.present?
          data = res.map do |res|
            {designation: designation, faculty_master_id: res.id, forenoon: "", name: res.faculty_name, attendance_date: date}
          end
        end
      end
      data
    end
    
  end
end
