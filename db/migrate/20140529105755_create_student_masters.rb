class CreateStudentMasters < ActiveRecord::Migration
  def change
    create_table :student_masters do |t|
      t.string :name
      t.date :dob
      t.date :joining_date
      t.string :grade
      t.string :section
      t.string :academic_year
      t.integer :parent_id
      t.string :finalresult
      t.string :closestatus
      t.string :description
      t.string :start_time
      t.string :end_time
      t.string :branch
      t.string :surname
      t.string :second_lang
      t.string :board
      t.string :medium
      t.string :year
      t.string :written
      t.string :reading
      t.string :spoken
      t.string :blood_group
      t.string :gender
      t.string :language
      t.string :admission_no
      t.string :allergy
      t.string :doctor_name
      t.string :doctor_mobile
      t.string :guardian_mobile
      t.string :guardian_name
      t.string :guardian_relationship
      t.string :from
      t.string :to
      t.string :middle_name
      t.string :klass
      t.string :father_name
      t.string :mother_name
      t.string :nationality
      t.string :income
      t.text :address
      t.string :landline
      t.string :mobile
      t.string :email
      t.string :transport
      t.string :busstop
      t.string :city
      t.string :changing_reason
      t.string :know_school
      t.string :last_school
      t.string :person
      t.string :pp
      t.string :status
      t.string :sib_name
      t.string :sib_age
      t.string :sib_sex
      t.string :sib_grade
      t.string :sib_school

      t.timestamps
    end
  end
end
