class CreateLocationMasters < ActiveRecord::Migration
  def change
    create_table :location_masters do |t|
      t.string :location_name

      t.timestamps
    end
  end
end
