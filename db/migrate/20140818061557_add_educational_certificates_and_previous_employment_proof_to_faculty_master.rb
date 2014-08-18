class AddEducationalCertificatesAndPreviousEmploymentProofToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :educational_certificates, :string
    add_column :faculty_masters, :previous_employment_proof, :string
  end
end
