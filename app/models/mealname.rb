class Mealname < ActiveRecord::Base
  belongs_to :mealtype
  scope :meal_names, lambda{|location_master_id| where(:location_master_id => location_master_id )}
end
