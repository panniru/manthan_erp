class AddStaffrecruitIdToStaffadmin < ActiveRecord::Migration
  def change
    add_column :staffadmins, :staffrecruit_id, :integer
  end
end
