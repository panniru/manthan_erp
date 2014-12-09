class CreateSetupMasters < ActiveRecord::Migration
  def change
    create_table :setup_masters do |t|
      t.float :casual_leave
      t.float :sick_leave

      t.timestamps
    end
  end
end
