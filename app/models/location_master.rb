class LocationMaster < ActiveRecord::Base
  has_one :special_day_transport
  geocoded_by :location_name  
  after_validation :geocode
end
