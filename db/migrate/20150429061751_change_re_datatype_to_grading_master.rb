class ChangeReDatatypeToGradingMaster < ActiveRecord::Migration
 def up
    change_column :grading_masters, :grading_score, :integer
  end

  def down
    change_column :grading_masters, :grading_score, :float
  end
end
