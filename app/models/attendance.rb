class Attendance < ActiveRecord::Base
  scope :active_at_date, lambda { where("attendance_date < :date and attendance_date > :date", date: Date.today )}
  
end
  
