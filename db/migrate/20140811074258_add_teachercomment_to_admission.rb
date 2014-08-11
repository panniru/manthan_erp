class AddTeachercommentToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :teachercomment, :string
  end
end
