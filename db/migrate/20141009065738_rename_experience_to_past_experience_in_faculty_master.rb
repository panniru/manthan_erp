class RenameExperienceToPastExperienceInFacultyMaster < ActiveRecord::Migration
  def change
    change_table :faculty_masters do |t|
      t.rename :experience, :past_experience
      t.rename :subject, :primary_subject
      
    end
  end
end
