class TimeTable < ActiveRecord::Base
  #self.primary_keys = :grade_master_id, :section_master_id

  validates :mon_sub, presence: true
  validates :tue_sub, presence: true
  validates :wed_sub, presence: true
  validates :thu_sub, presence: true
  validates :fri_sub, presence: true
  validates :sat_sub, presence: true

  belongs_to :grade_master
  belongs_to :section_master 
 # belongs_to :subject_master
end
