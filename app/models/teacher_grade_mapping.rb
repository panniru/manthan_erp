class TeacherGradeMapping < ActiveRecord::Base  
  belongs_to  :grade_master
  belongs_to  :section_master
  belongs_to  :subject_master
  belongs_to  :faculty_master

  validates :faculty_master_id, presence: true, allow_nil: false, allow_blank: false
  validates :grade_master_id, presence: true, allow_nil: false, allow_blank: false
  validates :section_master_id, presence: true, allow_nil: false, allow_blank: false
  validates :subject_master_id, presence: true, allow_nil: false, allow_blank: false  

  scope :belongs_to_faculty, lambda{|faculty| where(:faculty_master_id => faculty)}
  scope :belongs_to_grade_master, lambda{|grade_master| where("grade_master_id = ?",  grade_master)}
  scope :belongs_to_section_master, lambda{|section_master| where("section_master_id = ?",  section_master)}

  # def union
  #   "#{grade_master.grade_name} - #{section_master.section_name} - #{subject_master.subject_name}"
  # end
  

end
