class AddSubjectMasterIdToAssessmentTeacherMappings < ActiveRecord::Migration
  def change
  	change_table :assessment_teacher_mappings do |t|  	
    t.string :subject_master_id
    end	
  end
end
