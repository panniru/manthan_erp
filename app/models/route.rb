class Route < ActiveRecord::Base
  has_many :new_vehicle 
  has_many :student_route_mappings , :dependent => :destroy 
  has_many :locations , :dependent => :destroy
  has_many :location_masters
  accepts_nested_attributes_for :locations
  attr_accessor :text ,:subject
  scope :show_route_locations, lambda{|route_id| where(:route_id => route_id ).select(:id,:location_master_id, :sequence_no)}
  scope :up_route ,  where(lpp: 'Up route')
  scope :down_route ,  where(lpp: 'Down route')
  
  
  def student_length
    route = self.id
    map = StudentRouteMapping.show_all_students(route).map {|student| student.student_master_id}
    return map.length
  end
  
  def bus_capacity
    route = self.id
    map = StudentRouteMapping.show_all_students(route).map {|student| student.student_master_id}
    capacity =  NewVehicle.capacity_bus(self.busno_up).map {|cap| cap.capacity} 
    length = capacity.first - map.length
    return length
  end

  def save_route(location_params)
    location_params[:locations].each do |location|
      locations << Location.new(location.permit(:location_master_id, :sequence_no))
    end
    status = false
    ActiveRecord::Base.transaction do
      status = self.save!
      @sorted_locations = self.locations.sort{|l1,l2| l1.sequence_no <=> l2.sequence_no}
      status = self.update(:start_point => @sorted_locations.first.id, :end_point => @sorted_locations.last.id)
    end
    if  (location_params[:lpp] == 'Down Route')
      locations << Location.new({:location_master_id => '10', :sequence_no => sequence_no_last })
    else
      locations << Location.new({:location_master_id => '10', :sequence_no => sequence_no_first })
    end
    status
  end
  
  def sequence_no_last
    @sorted_locations = self.locations.sort{|l1,l2| l1.sequence_no <=> l2.sequence_no}
    @sorted_locations.last.sequence_no+1
  end

  def sequence_no_first
    @sorted_locations = self.locations.sort{|l1,l2| l1.sequence_no <=> l2.sequence_no}
    @sorted_locations.first.sequence_no-1
  end
  
  def update_route(params)
    p "params"
    p params
    # params[:route].each do |route_params| 
    #   params[:lpp] = route_params[:lpp]
    #   route.busno_up = route_params[:busno_up]
    # end
    params[:locations].each do |location_params|
      if location_params["id"].present?
        location = self.locations.find(location_params[:id])
        location.location_master_id = location_params[:location_master_id] 
        location.sequence_no = location_params[:sequence_no]
        location.save
      else
        locations << Location.new(location_params.permit(:location_master_id, :sequence_no ,:route_id))
        sorted_locations = self.locations.sort{|l1,l2| l1.sequence_no <=> l2.sequence_no}
        status = self.update(:start_point => sorted_locations.first.id, :end_point => sorted_locations.last.id)
      end
    end
  end
  
  def start_location
    Location.find(start_point)
  end
  
  def end_location
    Location.find(end_point)
  end

  def start_location_name
    start_location.location_master.location_name
  end

  def end_location_name
    end_location.location_master.location_name
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
