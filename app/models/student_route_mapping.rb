class StudentRouteMapping < ActiveRecord::Base
  has_many :student_masters
  belongs_to :routes
  scope :student , lambda{where("id not in (?)", StudentRouteMapping.all.map(&:student_master_id))} 
end
