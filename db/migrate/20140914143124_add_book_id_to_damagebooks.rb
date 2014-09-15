class AddBookIdToDamagebooks < ActiveRecord::Migration
  def change
  	add_column :damagebooks, :book_id, :integer
  end
end
