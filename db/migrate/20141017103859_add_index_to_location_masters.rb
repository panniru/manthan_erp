class AddIndexToLocationMasters < ActiveRecord::Migration
  def change
    add_column :location_masters, :index, :integer
  end
  
end
