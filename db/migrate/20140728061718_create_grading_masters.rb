class CreateGradingMasters < ActiveRecord::Migration
  def change
    create_table :grading_masters do |t|
      t.string :grading_name
      t.string :grading_desc

      t.timestamps
    end
  end
end
