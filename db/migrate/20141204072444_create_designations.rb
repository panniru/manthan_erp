class CreateDesignations < ActiveRecord::Migration
  def change
    create_table :designations do |t|
      t.string :designation

      t.timestamps
    end
  end
end
