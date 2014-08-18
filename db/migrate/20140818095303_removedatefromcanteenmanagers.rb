class Removedatefromcanteenmanagers < ActiveRecord::Migration
  def change
  	remove_column :canteenmanagers, :date, :date
  	add_column :canteenmanagers, :canteen_date, :date
  end
end
