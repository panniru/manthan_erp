class Documentuploader < ActiveRecord::Base
  mount_uploader :educational_certificates, EducationalCertificatesUploader# Teprevious_employment_proof, 
  mount_uploader :previous_employment_proof,PreviousEmploymentProofUploader
  mount_uploader :salary_slips_for_previous_months, SalarySlipsForPreviousMonthsUploader
  validates :name, presence: true # Make sure the owner's name is present.
end
