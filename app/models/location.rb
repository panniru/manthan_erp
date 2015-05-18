class Location < ActiveRecord::Base
  belongs_to :location_master
  belongs_to :route
  scope :map_location ,  lambda{|location_master_id| where(:location_master_id => location_master_id )}
  def get_bus_no
    bus = []
    bus << self.location_master.location_name
    Location.map_location(self.location_master_id).each do |x|
      if self.route.busno_up.present?
        bus << x.route.busno_up
      else
        bus << x.route.busno_down
      end
    end
    return bus.to_s
  end

  validates :sequence_no , :presence => true
  scope :equals_to_location_master, lambda{|location_master_id| where(:location_master_id => location_master_id )}
  scope :show_route_locations, lambda{|route_id| where(:route_id => route_id ).select(:id,:location_master_id, :sequence_no)}
  scope :up_routes, lambda{joins(:route).where("routes.lpp='Up Route'") }  
  scope :down_routes , lambda{joins(:route).where("routes.lpp= 'Down Route'")}
end
