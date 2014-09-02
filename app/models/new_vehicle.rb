class NewVehicle < ActiveRecord::Base
  acts_as_paranoid
  validates :make_of_bus , :presence => true
  validates :model_no, :presence => true
  validates :year_of_manufacture, :presence => true
  validates :purchase_option_date, :presence => true
  validates :capacity, :presence => true
end
