class AddGuardianDetailsToParentMasters < ActiveRecord::Migration
  def change
    add_column :parent_masters, :guardian_name, :string
    add_column :parent_masters, :guardian_email, :string
    add_column :parent_masters, :guardian_mobile, :string
    add_column :parent_masters, :guardian_occupation, :string
  end
end
