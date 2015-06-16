class Assessment < ActiveRecord::Base
  belongs_to :subject_master
  belongs_to :assessment_grade_mapping
end
