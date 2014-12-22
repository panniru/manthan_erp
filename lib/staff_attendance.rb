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
          {name: result.name, designation: designation,faculty_master_id: result.faculty_master_id, forenoon: result.forenoon, attendance_date: date, afternoon: result.afternoon, id: result.id, type_of_leave: result.type_of_leave, pending_casual_leave: result.get_pending_casual_leave(designation), pending_sick_leave: result.get_pending_sick_leave(designation),max_casual_leave: result.get_casual_leave(designation), max_sick_leave: result.get_sick_leave(designation)}
        end
      else
        res = FacultyMaster.on_designation(designation)
        p res
        p designation
        if res.present?
          data = res.map do |res|
            {designation: designation, faculty_master_id: res.id, forenoon: "", name: res.faculty_name, attendance_date: date, afternoon:"", max_sick_leave: res.get_sick_leave(designation) ,max_casual_leave: res.get_casual_leave(designation),type_of_leave:"",pending_casual_leave: res.get_pending_casual_leave(designation),pending_sick_leave: res.get_pending_sick_leave(designation)}
          end
        end
      end
      data
    end
    
  end
end
