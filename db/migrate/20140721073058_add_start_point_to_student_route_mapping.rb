class AddStartPointToStudentRouteMapping < ActiveRecord::Migration
  def change
    add_column :student_route_mappings, :start_point, :string
  end
end
