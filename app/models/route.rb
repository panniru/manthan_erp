class Route < ActiveRecord::Base
  acts_as_paranoid
 
  geocoded_by :lpp  
  after_validation :geocode
 
end
