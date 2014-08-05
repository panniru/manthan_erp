class AddAssessmentDateToAssessmentTeacherMapping < ActiveRecord::Migration
  def change
  	change_table :assessment_teacher_mappings do |t|  	
    t.date :assessment_date
    end	
  end
end
