class Changecolumnnameinbooks < ActiveRecord::Migration
  def change
    rename_column :books, :yop, :year_of_publishing
    rename_column :books, :noc, :number_of_copies
    rename_column :books, :dp, :purchased_date
  end
end
