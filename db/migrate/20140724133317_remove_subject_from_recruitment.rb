class RemoveSubjectFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :subject, :string
  end
end
