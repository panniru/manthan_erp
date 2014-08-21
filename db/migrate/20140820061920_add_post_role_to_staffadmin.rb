class AddPostRoleToStaffadmin < ActiveRecord::Migration
  def change
    add_column :staffadmins, :post_role, :string
  end
end
