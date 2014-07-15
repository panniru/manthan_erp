class AddBookToIssuing < ActiveRecord::Migration
  def change
    add_column :issuings, :book, :string
  end
end
