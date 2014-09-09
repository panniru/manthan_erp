class ChangeColumNameIsdnToIsbnInBooksTable < ActiveRecord::Migration
  def change
  	remove_column :books, :isdn, :string
  	add_column :books, :isbn, :string
  end
end
