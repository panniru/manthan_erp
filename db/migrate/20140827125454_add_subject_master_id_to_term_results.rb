class AddSubjectMasterIdToTermResults < ActiveRecord::Migration
  def change
  	change_table :term_results do |t|  	
    t.integer :subject_master_id
    end	
  end
end
