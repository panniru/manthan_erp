class CreateStaffrecruits < ActiveRecord::Migration
  def change
    create_table :staffrecruits do |t|
      t.string :form_no
      t.string :name
      t.string :dob
      t.string :status
      t.string :staffhead
      t.string :description
      t.string :start_time
      t.string :end_time
      t.string :educational_certificates
      t.string :previous_employment_proof
      t.string :salary_slips_for_previous_months
      t.string :title
      t.string :subject_master_id
      t.string :closestatus
      t.string :staff_admission_id
      t.string :comments
      t.string :final_result
      t.string :assessment_result
      t.string :management_result
      t.string :gender
      t.string :email
      t.string :mobile_no
      t.string :address
      t.string :nationality
      t.string :klass
      t.string :language
      t.string :subject
      t.string :experience
      t.string :expected_salary
      t.string :education_qualification
      t.string :post
      t.integer :staff_leader_id

      t.timestamps
    end
  end
end
