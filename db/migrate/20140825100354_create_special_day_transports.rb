class CreateSpecialDayTransports < ActiveRecord::Migration
  def change
    create_table :special_day_transports do |t|
      t.string :new_route_no
      t.integer :location_master_id
      t.integer :route_id
      t.string :new_up_route
      t.string :new_down_route
      t.string :new_busno_up
      t.string :new_busno_down
      t.string :time_up
      t.string :time_down
      t.date :date
      t.string :occation

      t.timestamps
    end
  end
end
