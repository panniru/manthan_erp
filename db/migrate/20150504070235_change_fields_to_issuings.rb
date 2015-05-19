class ChangeFieldsToIssuings < ActiveRecord::Migration
  def change
    remove_column :issuings, :grade, :string
    add_column :issuings, :grade_master_id, :integer
    remove_column :issuings, :section, :string
    add_column :issuings, :section_master_id, :integer
  end
end
