class AddBookIssueToIssuing < ActiveRecord::Migration
  def change
    add_column :issuings, :book_issue, :string
  end
end
