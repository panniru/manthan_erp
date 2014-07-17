class AddBookReturnToIssuing < ActiveRecord::Migration
  def change
    add_column :issuings, :book_return, :string
  end
end
