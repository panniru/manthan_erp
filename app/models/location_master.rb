class LocationMaster < ActiveRecord::Base
  
  before_destroy :cleanup
  geocoded_by :location_name  
  after_validation :geocode
  belongs_to :student_master
  validates :location_name, :presence => true
  belongs_to :route
  belongs_to :locations
  

  

  def cleanup
    route = Location.equals_to_location_master(self.id)
    if route.length==0
      return true
    else
      return false
    end
  end
  
end
