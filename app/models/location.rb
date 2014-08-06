class Location < ActiveRecord::Base
  belongs_to :location_master
  belongs_to :route
  scope :equals_to_location_master, lambda{|location_master_id| where(:location_master_id => location_master_id )}
end
