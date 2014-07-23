class AddDropPointToStudentRouteMapping < ActiveRecord::Migration
  def change
    add_column :student_route_mappings, :drop_point, :string
  end
end
