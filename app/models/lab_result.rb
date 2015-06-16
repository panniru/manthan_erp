class LabResult < ActiveRecord::Base
  # has_many :grading_masters
  belongs_to :student_master
  belongs_to :grading_master
  belongs_to :grade_master
  belongs_to :section_master
  belongs_to :listing
  belongs_to :lab_assessment
end
