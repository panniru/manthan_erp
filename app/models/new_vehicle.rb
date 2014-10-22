class NewVehicle < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :route 
  scope :capacity_bus, lambda{|id| where(:id => id ).select(:id,:capacity)}
  scope :no_buses, lambda{where("id not in (?)", Route.all.map(&:busno_up) )}
   
  def bus
    map = NewVehicle.no_buses.map{|bus| bus.id}
    return map
  end

  validates :make_of_bus , :presence => true
  validates :model_no, :presence => true
  validates :year_of_manufacture, :presence => true
  validates :purchase_option_date, :presence => true
  validates :capacity, :presence => true
end
