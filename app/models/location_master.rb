class LocationMaster < ActiveRecord::Base
  
  before_destroy :cleanup
  geocoded_by :location_name  
  after_validation :geocode
  belongs_to :student_master
  validates_uniqueness_of  :location_name, :presence => true
  belongs_to :route
  belongs_to :locations
  scope :greater, -> { where("id.count > ?", "7") }
  scope :less, -> { where("id.count < ?", "7") }
  scope :odd, -> { where("id % 2 = ?", "0") }
  scope :even, -> { where("id % 2 = ?", "1") }
  
  

  def cleanup
    route = Location.equals_to_location_master(self.id)
    if route.length==0
      return true
    else
      return false
    end
  end
  
end
