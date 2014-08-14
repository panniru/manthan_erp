class AddDateToCanteenmanagers < ActiveRecord::Migration
  def change
    add_column :canteenmanagers, :date, :date
  end
end
