class AddRoleIdToStaffrecruit < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :role_id, :integer
  end
end
