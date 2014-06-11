class RenameGradeToGradeIdInStudentMasters < ActiveRecord::Migration
  def change
    rename_column :student_masters, :grade , :grade_master_id
  end
end
