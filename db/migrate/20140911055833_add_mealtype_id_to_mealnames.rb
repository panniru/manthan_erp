class AddMealtypeIdToMealnames < ActiveRecord::Migration
  def change
    add_column :mealnames, :mealtype_id, :integer
  end
end
