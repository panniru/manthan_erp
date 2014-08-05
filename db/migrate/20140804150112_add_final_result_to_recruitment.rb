class AddFinalResultToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :final_result, :string
  end
end
