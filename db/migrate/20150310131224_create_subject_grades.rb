class CreateSubjectGrades < ActiveRecord::Migration
  def change
    create_table :subject_grades do |t|
      t.string :grade_master_id
      t.string :subject_master_id

      t.timestamps
    end
  end
end
