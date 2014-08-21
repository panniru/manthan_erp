class AddFormNoToStudentMaster < ActiveRecord::Migration
  def change
    add_column :student_masters, :form_no, :string
  end
end
