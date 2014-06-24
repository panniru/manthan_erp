class CreateTeacherGradeMappings < ActiveRecord::Migration
  def change
    create_table :teacher_grade_mappings do |t|
      t.integer :user_id
      t.string :grade_master_id
      t.string :section_master_id
      t.string :subject_master_id

      t.timestamps
    end
  end
end
