class AddGradingScoreToGradingMaster < ActiveRecord::Migration
  def change
    add_column :grading_masters, :grading_score, :float
  end
end
