class CreateIssuings < ActiveRecord::Migration
  def change
    create_table :issuings do |t|
      t.string :name
      t.string :grade
      t.string :section

      t.timestamps
    end
  end
end
