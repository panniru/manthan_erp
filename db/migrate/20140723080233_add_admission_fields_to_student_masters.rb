class AddAdmissionFieldsToStudentMasters < ActiveRecord::Migration
  def change
    add_column   :student_masters, :branch_id, :integer
    add_column   :student_masters, :surname, :string
    add_column   :student_masters, :second_lang, :string
    add_column   :student_masters, :board, :string
    add_column   :student_masters, :medium, :string
    add_column   :student_masters, :year, :string
    add_column   :student_masters, :written, :string
    add_column   :student_masters, :reading, :string
    add_column   :student_masters, :spoken, :string
    add_column   :student_masters, :blood_group, :string
    add_column   :student_masters, :gender, :string
    add_column   :student_masters, :nationality, :string
    add_column   :student_masters, :language, :string
    add_column   :student_masters, :last_school, :string
    add_column   :student_masters, :address_line1, :string
    add_column   :student_masters, :address_line2, :string
    add_column   :student_masters, :city, :string
    add_column   :student_masters, :state, :string
    add_column   :student_masters, :pin, :string
  end
end
