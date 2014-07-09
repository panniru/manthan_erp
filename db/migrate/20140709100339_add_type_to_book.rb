class AddTypeToBook < ActiveRecord::Migration
  def change
    add_column :books, :book_type, :string
  end
end
