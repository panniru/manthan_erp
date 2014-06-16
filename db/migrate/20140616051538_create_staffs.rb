class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :staff_name
      t.string :staff_exp
      t.string :grade
      t.string :start_time
      t.string :end_time
      t.string :period
      t.string :date

      t.timestamps
    end
  end
end
