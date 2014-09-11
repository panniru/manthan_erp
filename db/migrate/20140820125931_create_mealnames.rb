class CreateMealnames < ActiveRecord::Migration
  def change
    create_table :mealnames do |t|
      t.integer :meal_type_id
      t.string :meal_detail_name
      t.date :canteen_date

      t.timestamps
    end
  end
end
