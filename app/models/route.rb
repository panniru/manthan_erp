class Route < ActiveRecord::Base
  geocoded_by :lpp  
  after_validation :geocode        
end
