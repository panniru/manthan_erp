class CreateCanteenmanagers < ActiveRecord::Migration
  def change
    create_table :canteenmanagers do |t|
      t.string :breakfast
      t.string :lunch
      t.string :snacks
      t.string :dinner

      t.timestamps
    end
  end
end
