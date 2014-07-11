class CreateNewVehicles < ActiveRecord::Migration
  def change
    create_table :new_vehicles do |t|
      t.string :model_no
      t.string :make_of_bus
      t.date :yom
      t.string :purchase_option
      t.date :purchase_option_date
      t.integer :capacity

      t.timestamps
    end
  end
end
