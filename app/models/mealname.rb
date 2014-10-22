class Mealname < ActiveRecord::Base
  belongs_to :mealtype
  scope :meal_names, lambda{|location_master_id| where(:location_master_id => location_master_id )}
  scope :on_date, lambda { |date| where("canteen_date = ? ", date)}

  def self.date_wise_meals
    data = {}
    self.all.each do |meal|
      meal_on_date = data[meal.canteen_date]
      unless meal_on_date.present?
        meal_on_date = {} 
        data[meal.canteen_date] = meal_on_date
      end
      meal_on_date[meal.mealtype.meal_type] = meal.meal_detail_name
    end
    data
  end
end
