class RemoveEmailFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :email, :string
  end
end
