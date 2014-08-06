class AddTitleToStaffadmin < ActiveRecord::Migration
  def change
    add_column :staffadmins, :title, :string
  end
end
