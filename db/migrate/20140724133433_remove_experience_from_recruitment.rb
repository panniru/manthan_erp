class RemoveExperienceFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :experience, :string
  end
end
