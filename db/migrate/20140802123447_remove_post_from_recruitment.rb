class RemovePostFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :post, :string
  end
end
