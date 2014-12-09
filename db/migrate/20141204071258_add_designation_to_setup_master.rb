class AddDesignationToSetupMaster < ActiveRecord::Migration
  def change
    add_column :setup_masters, :designation, :string
  end
end
