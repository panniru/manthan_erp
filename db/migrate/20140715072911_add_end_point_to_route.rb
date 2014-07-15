class AddEndPointToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :end_point, :string
  end
end
