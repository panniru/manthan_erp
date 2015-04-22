class LabResult < ActiveRecord::Base
  has_many :grading_masters
  # has_many :student_masters
  belongs_to :student_master
  belongs_to :grading_master
end
