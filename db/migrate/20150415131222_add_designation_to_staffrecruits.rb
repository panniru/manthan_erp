class AddDesignationToStaffrecruits < ActiveRecord::Migration
  def change
    add_column :staffrecruits, :designation, :string
  end
end
