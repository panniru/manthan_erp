class LocationMaster < ActiveRecord::Base
  geocoded_by :location_name  
  after_validation :geocode
  belongs_to :student_master
  validates :location_name, :presence => true
  belongs_to :route
end
