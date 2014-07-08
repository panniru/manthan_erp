class AddYearToBook < ActiveRecord::Migration
  def change
    add_column :books, :year, :string
  end
end
