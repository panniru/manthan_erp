class CreateDamagebooks < ActiveRecord::Migration
  def change
    create_table :damagebooks do |t|
      t.string :isbn
      t.string :book_stage
      t.string :damage_type
      t.string :damage_description

      t.timestamps
    end
  end
end
