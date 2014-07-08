class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :isdn
      t.string :author
      t.date :yop
      t.string :noc
      t.date :dp

      t.timestamps
    end
  end
end
