class Route < ActiveRecord::Base
  has_many :locations
  has_many :location_masters
  accepts_nested_attributes_for :locations
  attr_accessor :text ,:subject
  
  def save_route(location_params)
    location_params.each do |location|
      locations << Location.new(location.permit(:location_master_id, :sequence_no))
    end
    status = false
    ActiveRecord::Base.transaction do
      status = self.save!
      sorted_locations = self.locations.sort{|l1,l2| l1.sequence_no <=> l2.sequence_no}
      status = self.update(:start_point => sorted_locations.first.id, :end_point => sorted_locations.last.id)
    end
    status
  end
  
  def start_location
    Location.find(start_point)
  end
  
  def end_location
    Location.find(end_point)
  end
  
  def slice_out(bus)
    dead = [ ]
    bus.delete_if do |e|
      if(yield e)
        dead.push(e)
        true
      else
        false  
      end
    end
    dead
  end
  

end
