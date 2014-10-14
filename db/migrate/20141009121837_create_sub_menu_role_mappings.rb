class CreateSubMenuRoleMappings < ActiveRecord::Migration
  def change
    create_table :sub_menu_role_mappings do |t|
      t.integer :sub_menu_id
      t.integer :main_menu_id
      t.integer :role_id
    end
  end
end
