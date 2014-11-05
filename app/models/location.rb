class Location < ActiveRecord::Base
  belongs_to :location_master
  belongs_to :route
  validates :sequence_no , :presence => true
  scope :equals_to_location_master, lambda{|location_master_id| where(:location_master_id => location_master_id )}
  scope :show_route_locations, lambda{|route_id| where(:route_id => route_id ).select(:id,:location_master_id, :sequence_no)}
  scope :up_routes, lambda{joins(:route).where("routes.lpp='Up Route'") }  
  scope :down_routes , lambda{joins(:route).where("routes.lpp= 'Down Route'")}
end
