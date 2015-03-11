class CreateDesignationMasters < ActiveRecord::Migration
  def change
    create_table :designation_masters do |t|
      t.string :name
      t.string :code
      t.integer :managed_by

      t.timestamps
    end
  end
end
