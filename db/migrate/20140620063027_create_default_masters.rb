class CreateDefaultMasters < ActiveRecord::Migration
  def change
    create_table :default_masters do |t|
      t.string :default_name
      t.string :default_value
      t.string :default_desc

      t.timestamps
    end
  end
end
