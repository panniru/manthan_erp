class AddFatherEducationAndMotherEducationToParentMaster < ActiveRecord::Migration
  def change
    add_column :parent_masters, :father_education, :string
    add_column :parent_masters, :mother_education, :string
  end
end
