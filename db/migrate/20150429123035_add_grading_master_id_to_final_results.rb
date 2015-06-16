class AddGradingMasterIdToFinalResults < ActiveRecord::Migration
  def change
    add_column :final_results, :grading_master_id, :integer
  end
end
