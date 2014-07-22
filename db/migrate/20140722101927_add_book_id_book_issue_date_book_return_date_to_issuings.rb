class AddBookIdBookIssueDateBookReturnDateToIssuings < ActiveRecord::Migration
  def change
    add_column :issuings, :book_id, :integer
    add_column :issuings, :book_issue_date, :date
    add_column :issuings, :book_return_date, :date
  end
end
