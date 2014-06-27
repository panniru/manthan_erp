class CreateFacultyMasters < ActiveRecord::Migration
  def change
    create_table :faculty_masters do |t|
      t.integer :user_id
      t.string :faculty_name

      t.timestamps
    end
  end
end
