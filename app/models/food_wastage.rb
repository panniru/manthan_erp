class FoodWastage < ActiveRecord::Base
  validates :wastage, presence: true
end
