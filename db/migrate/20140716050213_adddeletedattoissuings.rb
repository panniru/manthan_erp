class Adddeletedattoissuings < ActiveRecord::Migration
  def change
    add_column :issuings, :deleted_at, :datetime
    add_index :issuings, :deleted_at
  end
end
