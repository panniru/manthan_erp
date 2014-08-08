class AddAssessmentDescriptionToAssessmentTeacherMappings < ActiveRecord::Migration
  def change
  	change_table :assessment_teacher_mappings do |t|  	
    t.string :assessment_desc
    end	
  end
end
