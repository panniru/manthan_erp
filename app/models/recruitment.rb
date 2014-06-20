class Recruitment < ActiveRecord::Base
  validates :title, :presence => true
  validates :education_details, :presence => true
  validates :experience, :presence => true
end
