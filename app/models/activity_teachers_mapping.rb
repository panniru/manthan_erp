class ActivityTeachersMapping < ActiveRecord::Base
  belongs_to :activity_master  
  belongs_to :faculty_master
  belongs_to :subject_master
end
