class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :form_no
      t.string :name
      t.string :dob
      t.string :gender
      t.string :email
      t.string :mobile_no
      t.string :address
      t.string :language, array: true
      t.string :experience
      t.string :klass
      t.string :subject
      t.string :education_qualification
      t.string :expected_salary
      t.string :nationality
      t.string :post
      t.string :status
      t.string :staff_name
      t.string :description
      t.string :start_time
      t.string :end_time
      t.string :educational_certificates
      t.string :previous_employment_proof
      t.string :salary_slips_for_previous_months
      t.string :title

      t.timestamps
    end
  end
end
