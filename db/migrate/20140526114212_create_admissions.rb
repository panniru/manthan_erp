class CreateAdmissions < ActiveRecord::Migration
  def change
    create_table :admissions do |t|
      t.string :admission_no

      t.string :branch
      t.string :surname
      t.string :second_lang
      t.string :board
      t.string :grade
      t.string :medium
      t.integer :year
      t.string :written
      t.string :reading
      t.string :spoken
      t.string :blood_group
      t.string :allergy
      t.string :doctor_name
      t.string :doctor_mobile
      t.string :guardian_name
      t.string :guardian_mobile
      t.string :guardian_relationship
      t.string :from
      t.string :to
      t.string :middle_name
      t.string :father_office_address
      t.string :mother_office_address
      t.string :father_office_telephone
      t.string :mother_office_telephone
      t.string :father_mobile
      t.string :mother_mobile
      t.string :mother_religion
      t.string :father_religion
      t.string :father_employer
      t.string :mother_employer
      t.string :father_email
      t.string :mother_email
      t.string :sib_name
      t.string :sib_age
      t.string :sib_sex
      t.string :sib_grade
      t.string :sib_school
      t.string :bus
      t.timestamps
    end
  end
end
