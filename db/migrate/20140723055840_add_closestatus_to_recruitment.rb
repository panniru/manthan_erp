class AddClosestatusToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :closestatus, :string
  end
end
