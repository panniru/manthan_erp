class Result < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :grading_master
  belongs_to :grade_master
end
