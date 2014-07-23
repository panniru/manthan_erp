class AddPickUpPointToStudentRouteMapping < ActiveRecord::Migration
  def change
    add_column :student_route_mappings, :pick_up_point, :string
  end
end
