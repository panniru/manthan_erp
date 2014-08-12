class AddManagementResultToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :management_result, :string
  end
end
