class CreateDayEnds < ActiveRecord::Migration
  def change
    create_table :day_ends do |t|
      t.date :transaction_date
      t.integer :scrolled_by
      
      t.timestamps
    end
  end
end
