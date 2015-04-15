class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :subject_master_id
      t.integer :lab_assessment_id
      t.integer :grade_master_id
      t.date :assessment_date
      t.string :assessment_description
      t.string :assessment_name

      t.timestamps
    end
  end
end
