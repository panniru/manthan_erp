class AddStartTimeAndEndTimeToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :start_time, :string
    add_column :admissions, :end_time, :string
  end
end
