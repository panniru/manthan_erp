class ClassTeacherMapping < ActiveRecord::Base
  #validates :faculty_master_id , :uniqueness => true
  has_many :students, :class_name => "StudentMaster"
  belongs_to :grade_master
  belongs_to  :section_master  
  belongs_to  :faculty_master
  belongs_to  :attendance

  validates :faculty_master_id, presence: true
  validates :grade_master_id, presence: true
  validates :section_master_id, presence: true
  validate :unique_grade_and_section
  def unique_grade_and_section
    if ClassTeacherMapping.where(:grade_master_id => grade_master_id, :section_master_id => section_master_id).count >0
      self.errors.add("Grade and section already exists")
    end
  end

  scope :show_all_students, lambda{|faculty_master_id| where(:faculty_master_id => faculty_master_id ).select(:grade_master_id,:section_master_id)}

end
