class CreateFoodWastages < ActiveRecord::Migration
  def change
    create_table :food_wastages do |t|
      t.date :current_date
      t.integer :wastage

      t.timestamps
    end
  end
end
