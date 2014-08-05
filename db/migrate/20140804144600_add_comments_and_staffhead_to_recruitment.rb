class AddCommentsAndStaffheadToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :comments, :string
    add_column :recruitments, :staffhead, :string
  end
end
