class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location
      t.integer :sequence_no
      t.integer :route_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
