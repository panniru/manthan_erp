class CreateLabResults < ActiveRecord::Migration
  def change
    create_table :lab_results do |t|
      t.integer :grading_master_id
      t.integer :student_master_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
