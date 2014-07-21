class LocationMaster < ActiveRecord::Base

  geocoded_by :location_name  
  after_validation :geocode
end
