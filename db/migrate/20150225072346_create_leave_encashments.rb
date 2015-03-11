class CreateLeaveEncashments < ActiveRecord::Migration
  def change
    create_table :leave_encashments do |t|
      t.integer :faculty_master_id
      t.date :date
      t.integer :no_of_leaves_to_be_encashed
      t.string :code

      t.timestamps
    end
  end
end
