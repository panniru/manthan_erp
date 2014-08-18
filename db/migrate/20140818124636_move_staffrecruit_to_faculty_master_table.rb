class MoveStaffrecruitToFacultyMasterTable < ActiveRecord::Migration
  def self.up
    Staffrecruit.where("educational_certificates IS NOT NULL and previous_employment_proof IS NOT NULL and salary_slips_for_previous_months IS NOT NULL").all.each{ |sr|
      fam = FacultyMaster.create(:faculty_master => sr) 
      fam.write_uploader(:educational_certificates, sr.educational_certificates) 
      fam.write_uploader(:previous_employment_proof, sr.previous_employment_proof)
      fam.write_uploader(:salary_slips_for_previous_months, sr.salary_slips_for_previous_months) 
      fam.save!
      
    }
  end
end
