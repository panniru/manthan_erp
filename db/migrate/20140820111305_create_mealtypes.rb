class CreateMealtypes < ActiveRecord::Migration
  def change
    create_table :mealtypes do |t|
      t.string :meal_type
      t.string :time

      t.timestamps
    end
  end
end
