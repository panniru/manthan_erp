class CreateHolidaycalendars < ActiveRecord::Migration
  def change
    create_table :holidaycalendars do |t|
      t.date :holiday_date
      t.string :description

      t.timestamps
    end
  end
end
