class AddLppToStudentRouteMappings < ActiveRecord::Migration
  def change
    add_column :student_route_mappings, :lpp, :string
  end
end
