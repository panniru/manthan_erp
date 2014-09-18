class AddBookIdToBlockBooks < ActiveRecord::Migration
  def change
  	add_column :block_books, :book_id, :integer
  end
end
