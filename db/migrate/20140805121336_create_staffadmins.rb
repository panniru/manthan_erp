class CreateStaffadmins < ActiveRecord::Migration
  def change
    create_table :staffadmins do |t|
      t.string :dept
      t.string :head
      t.integer :recruitment_id
      t.integer :staff_admission_id

      t.timestamps
    end
  end
end
