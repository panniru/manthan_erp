class AddFatherNationalityAndMotherNationalityToParentMaster < ActiveRecord::Migration
  def change
    add_column :parent_masters, :father_nationality, :string
    add_column :parent_masters, :mother_nationality, :string
  end
end
