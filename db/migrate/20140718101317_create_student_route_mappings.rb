class CreateStudentRouteMappings < ActiveRecord::Migration
  def change
    create_table :student_route_mappings do |t|
      t.integer :route_id
      t.integer :student_master_id

      t.timestamps
    end
  end
end
