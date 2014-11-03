class NewVehicle < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :route 
  scope :capacity_bus, lambda{|id| where(:id => id ).select(:id,:capacity)}
  scope :no_buses_up, lambda{where("id not in (?)", Route.all.map(&:busno_up).select(&:present?) )}
  scope :no_buses_down, lambda{where("id not in (?)", Route.all.map(&:busno_down).select(&:present?) )}

 

  def self.bus_up
    if (no_buses_up.length == 0 )
      map = NewVehicle.all.map{|bus| bus.id}
    else
      map = NewVehicle.no_buses_up.map{|bus| bus.id}
      
    end
    return map
  end
  
  def self.bus_down
    if (no_buses_down.length == 0 )
      map = NewVehicle.all.map{|bus| bus.id}
    else
      map = NewVehicle.no_buses_down.map{|bus| bus.id}
    end
    return map
  end
  
  
  validates :make_of_bus , :presence => true
  validates :model_no, :presence => true
  validates :year_of_manufacture, :presence => true
  validates :purchase_option_date, :presence => true
  validates :capacity, :presence => true
end
