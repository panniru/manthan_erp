class AddDeptToStaffrecruit < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :dept, :string
  end
end
