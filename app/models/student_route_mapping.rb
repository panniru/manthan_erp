class StudentRouteMapping < ActiveRecord::Base
  has_many :student_masters
  belongs_to :routes
end
