class CreateLabCriteria < ActiveRecord::Migration
  def change
    create_table :lab_criteria do |t|
      t.integer :lab_master_id
      t.string :lab_criteria
      t.integer :grade_master_id

      t.timestamps
    end
  end
end
