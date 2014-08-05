class CreateStaffAdmissions < ActiveRecord::Migration
  def change
    create_table :staff_admissions do |t|
      t.string :form_no
      t.string :name
      t.string :dob
      t.string :gender
      t.string :email
      t.string :mobile_no
      t.text :address
      t.string :nationality
      t.string :klass
      t.text :language
      t.string :subject
      t.string :experience
      t.string :expected_salary
      t.string :education_qualification
      t.string :status

      t.timestamps
    end
  end
end
