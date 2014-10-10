class RemoveFieldsFromFacultyMaster < ActiveRecord::Migration
  def change
    remove_column :faculty_masters, :form_no, :string
    remove_column :faculty_masters, :status, :string
    remove_column :faculty_masters, :description, :string
    remove_column :faculty_masters, :staffhead, :string
    remove_column :faculty_masters, :end_time, :string
    remove_column :faculty_masters, :start_time, :string
    remove_column :faculty_masters, :educational_certificates, :string
    remove_column :faculty_masters, :previous_employment_proof, :string
    remove_column :faculty_masters, :title, :string
    remove_column :faculty_masters, :salary_slips_for_previous_months, :string
    remove_column :faculty_masters, :subject_master_id, :integer
    remove_column :faculty_masters, :staff_leader_id, :integer
    remove_column :faculty_masters, :closestatus, :string
    remove_column :faculty_masters, :comments, :string
    remove_column :faculty_masters, :final_result, :string
    remove_column :faculty_masters, :management_result, :string
    remove_column :faculty_masters, :assessment_result, :string
    remove_column :faculty_masters, :klass, :string
    remove_column :faculty_masters, :expected_salary, :string
    remove_column :faculty_masters, :post, :string
    remove_column :faculty_masters, :staff_admission_id, :integer
    remove_column :faculty_masters, :faculty_master_id, :integer
  end
end
