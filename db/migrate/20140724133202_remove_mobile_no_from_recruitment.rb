class RemoveMobileNoFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :mobile_no, :string
  end
end
