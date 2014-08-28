class AddLocationMasterIdToStudentRouteMapping < ActiveRecord::Migration
  def change
    add_column :student_route_mappings, :location_master_id, :integer
  end
end
