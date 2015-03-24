class CreateLabAssessments < ActiveRecord::Migration
  def change
    create_table :lab_assessments do |t|
      t.string :assessment_type

      t.timestamps
    end
  end
end
