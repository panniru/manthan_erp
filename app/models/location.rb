class Location < ActiveRecord::Base
  geocoded_by :location  
  after_validation :geocode
  belongs_to :route
end
