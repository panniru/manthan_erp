class CreateStaffLeaders < ActiveRecord::Migration
  def change
    create_table :staff_leaders do |t|
      t.string :heads

      t.timestamps
    end
  end
end
