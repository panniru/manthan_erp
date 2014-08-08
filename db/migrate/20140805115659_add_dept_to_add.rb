class AddDeptToAdd < ActiveRecord::Migration
  def change
    add_column :adds, :dept, :string
  end
end
