class Route < ActiveRecord::Base
  acts_as_paranoid
  has_many :locations
 

  accepts_nested_attributes_for :locations

  def add_locations(location_params)
    location_params.each do |location|
      locations << Location.new(location)
    end
  end
 
end
