class RemoveGenderFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :gender, :string
  end
end
