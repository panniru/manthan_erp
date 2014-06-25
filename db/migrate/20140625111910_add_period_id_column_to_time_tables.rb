class AddPeriodIdColumnToTimeTables < ActiveRecord::Migration
  def change
    change_table :time_tables do |t|
      t.integer :period_id
    end	
  end
end
