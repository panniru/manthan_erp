class AddGradingMasterIdToAssessmentResults < ActiveRecord::Migration
  def change
  	change_table :assessment_results do |t|  	
    	t.string :grading_master_id
    end	
  end
end
