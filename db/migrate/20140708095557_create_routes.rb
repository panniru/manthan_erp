class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :route_no
      t.string :no_of_stops
      t.string :lpp
      t.string :distance
      t.integer :busno_up
      t.integer :busno_down
      t.integer :no_of_children
      t.integer :sequence_no

      t.timestamps
    end
  end
end
