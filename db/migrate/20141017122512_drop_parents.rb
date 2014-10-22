class DropParents < ActiveRecord::Migration
  def change
    drop_table :parents
  end
end
