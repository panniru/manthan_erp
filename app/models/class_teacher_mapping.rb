class ClassTeacherMapping < ActiveRecord::Base
  validates :faculty_master_id , :uniqueness => true
  has_many :students, :class_name => "StudentMaster"
  belongs_to :grade_master
  belongs_to  :section_master  
  belongs_to  :faculty_master
end
