class AddBookStatusToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :book_status, :string
  end
end
