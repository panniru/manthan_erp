module StaffAttendance
  class FacultyAttendan
    def initialize(std)
      @student = std
    end


    def self.attendance_on_date(date, designation)
      p designation
      results = FacultyAttendance.on_designation(designation)
      data = []
      if results.count > 0
        data = results.map do |result|
          {name: result.name, designation: designation,id: result.id, forenoon: result.attendance, attendance_date: result.attendance_date}
        end
      else
        res = FacultyMaster.on_designation(designation)
        p res
        p designation
        if res.present?
          data = res.map do |res|
            {designation: designation, id: res.id, forenoon: "", name: res.faculty_name, attendance_date: date}
          end
        end
      end
      data
    end
    
  end
end
