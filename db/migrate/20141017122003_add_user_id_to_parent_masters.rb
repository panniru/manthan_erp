class AddUserIdToParentMasters < ActiveRecord::Migration
  def change
    add_column :parent_masters, :user_id, :integer
  end
end
