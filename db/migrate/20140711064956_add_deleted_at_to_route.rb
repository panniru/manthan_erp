class AddDeletedAtToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :deleted_at, :datetime
    add_index :routes, :deleted_at
  end
end
