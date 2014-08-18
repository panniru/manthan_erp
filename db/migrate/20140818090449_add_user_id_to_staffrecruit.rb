class AddUserIdToStaffrecruit < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :user_id, :integer
  end
end
