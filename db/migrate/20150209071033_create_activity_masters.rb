class CreateActivityMasters < ActiveRecord::Migration
  def change
    create_table :activity_masters do |t|
      t.string :activity_name

      t.timestamps
    end
  end
end
