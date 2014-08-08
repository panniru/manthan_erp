class RemoveLanguageFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :language, :string
  end
end
