class CreatePrincipalApprovals < ActiveRecord::Migration
  def change
    create_table :principal_approvals do |t|
      t.string :book_name
      t.string :author_name
      t.string :status

      t.timestamps
    end
  end
end
