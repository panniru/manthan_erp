class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :quantity
      t.string :type

      t.timestamps
    end
  end
end
