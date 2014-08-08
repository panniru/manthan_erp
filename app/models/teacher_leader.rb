class TeacherLeader < ActiveRecord::Base
  validates :klass, :presence => true, :uniqueness => true
  validates :faculty_leader, :presence => true
end
