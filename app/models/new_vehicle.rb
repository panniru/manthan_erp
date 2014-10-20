class NewVehicle < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :route
  scope :capacity_bus, lambda{|id| where(:id => id ).select(:id,:capacity)}
 
  validates :make_of_bus , :presence => true
  validates :model_no, :presence => true
  validates :year_of_manufacture, :presence => true
  validates :purchase_option_date, :presence => true
  validates :capacity, :presence => true
end
