class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :form_no
      t.string :name
      t.string :klass
      t.string :dob
      t.string :gender
      t.string :nationality
      t.string :language
      t.string :father_name
      t.string :mother_name
      t.string :father_occupation
      t.string :mother_occupation
      t.string :father_company
      t.string :mother_company
      t.string :father_education
      t.string :mother_education
      t.string :income
      t.text :address
      t.string :landline
      t.string :mobile
      t.string :email
      t.string :transport
      t.string :busstop
      t.string :last_school
      t.string :city
      t.string :changing_reason
      t.string :know_school
      t.string :person
      t.string :pp
      t.string :appno
      t.string :status

      t.timestamps
    end
  end
end
