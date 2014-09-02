class StudentRouteMapping < ActiveRecord::Base
  has_many :student_masters
  scope :show_all_students, lambda{|route_id| where(:route_id => route_id ).select(:student_master_id, :location_master_id)}
  scope :show_all_locations, lambda{|location_master_id| where(:location_master_id => location_master_id ).select(:student_master_id)}
end
