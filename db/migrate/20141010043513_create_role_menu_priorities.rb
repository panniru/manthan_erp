class CreateRoleMenuPriorities < ActiveRecord::Migration
  def change
    create_table :role_menu_priorities do |t|
      t.integer :role_id
      t.integer :main_menu_id
      t.integer :priority

      t.timestamps
    end
  end
end
