class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.string :academic_year
      t.string :gradeid
      t.string :section
      t.string :periodid
      t.string :mon_sub
      t.string :tue_sub
      t.string :wed_sub
      t.string :thu_sub
      t.string :fri_sub
      t.string :sat_sub
      t.string :sun_sub
      t.time :st_time
      t.time :end_time

      t.timestamps
    end
  end
end
