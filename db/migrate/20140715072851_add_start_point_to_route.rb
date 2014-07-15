class AddStartPointToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :start_point, :string
  end
end
