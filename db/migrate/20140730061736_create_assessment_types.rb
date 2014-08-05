class CreateAssessmentTypes < ActiveRecord::Migration
  def change
    create_table :assessment_types do |t|
      t.string :assessment_type

      t.timestamps
    end
  end
end
