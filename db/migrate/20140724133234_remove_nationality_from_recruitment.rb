class RemoveNationalityFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :nationality, :string
  end
end
