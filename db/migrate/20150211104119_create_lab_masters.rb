class CreateLabMasters < ActiveRecord::Migration
  def change
    create_table :lab_masters do |t|
      t.string :lab_name
      t.integer :faculty_id

      t.timestamps
    end
  end
end
