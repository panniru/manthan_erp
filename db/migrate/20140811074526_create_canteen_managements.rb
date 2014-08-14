class CreateCanteenManagements < ActiveRecord::Migration
  def change
    create_table :canteen_managements do |t|
      t.string :meal_name
      t.string :time
      t.string :description

      t.timestamps
    end
  end
end
