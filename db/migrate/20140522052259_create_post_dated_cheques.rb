class CreatePostDatedCheques < ActiveRecord::Migration
  def change
    create_table :post_dated_cheques do |t|
      t.integer :date
      t.integer :month
      t.integer :academic_year
      t.float :amount_per

      t.timestamps
    end
  end
end
