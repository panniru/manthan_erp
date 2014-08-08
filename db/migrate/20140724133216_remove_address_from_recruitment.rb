class RemoveAddressFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :address, :string
  end
end
