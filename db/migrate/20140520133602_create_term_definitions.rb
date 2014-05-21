class CreateTermDefinitions < ActiveRecord::Migration
  def change
    create_table :term_definitions do |t|
      t.string :term_definition
      t.string :amount
      t.string :percent

      t.timestamps
    end
  end
end
