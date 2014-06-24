class TimeTable < ActiveRecord::Base
  #self.primary_keys = :grade_master_id, :section_master_id
  belongs_to :grade_master
  belongs_to :section_master 
end
