class Location < ActiveRecord::Base
  belongs_to :location_master
  belongs_to :route
  validates :sequence_no , :presence => true
  scope :has_no_route , lambda{where("id not in (?)", StudentRouteMapping.all.map(&:student_master_id))}
  scope :equals_to_location_master, lambda{|location_master_id| where(:location_master_id => location_master_id )}
  scope :show_route_locations, lambda{|route_id| where(:route_id => route_id ).select(:id,:location_master_id, :sequence_no)}
end
