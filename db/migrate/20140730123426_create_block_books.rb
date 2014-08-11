class CreateBlockBooks < ActiveRecord::Migration
  def change
    create_table :block_books do |t|
      t.string :isbn
      t.string :blocked_by

      t.timestamps
    end
  end
end
