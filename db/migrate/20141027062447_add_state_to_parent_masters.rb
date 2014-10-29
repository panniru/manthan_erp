class AddStateToParentMasters < ActiveRecord::Migration
  def change
    add_column :parent_masters, :state, :string
  end
end
