class RenameExperienceToPastExperienceInFacultyMaster < ActiveRecord::Migration
  def change

    change_table :faculty_masters do |t|
      t.rename :experience, :past_experience
      t.rename :subject, :primary_subject
    end

    change_table :student_masters do |t|
      t.rename :parent_id, :parent_master_id
    end
    
    change_table :admissions do |t|
      t.rename :sib_name, :sib_name1
      t.rename :sib_age, :sib_age1
      t.rename :sib_sex, :sib_sex1
      t.rename :sib_grade, :sib_grade1
      t.rename :sib_school, :sib_school1
    end

  end
end
