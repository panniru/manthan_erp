class ClassTeacherMapping < ActiveRecord::Base
  validates :faculty_master_id , :uniqueness => true
  has_many :students, :class_name => "StudentMaster"
  belongs_to :grade_master
  belongs_to  :section_master  
  belongs_to  :faculty_master
  scope :show_all_students, lambda{|faculty_master_id| where(:faculty_master_id => faculty_master_id ).select(:grade_master_id,:section_master_id)}
end
