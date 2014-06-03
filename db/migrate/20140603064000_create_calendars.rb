class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :event
      t.string :teacher
      t.date :date
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
