class ChangeDatatypeToGradingMaster < ActiveRecord::Migration
  def up
    change_column :grading_masters, :grading_score, :float
  end

  def down
    change_column :grading_masters, :grading_score, :integer
  end
end
