class CreateSubMenus < ActiveRecord::Migration
  def change
    create_table :sub_menus do |t|
      t.string :sub_menu_name
      t.string :icon_class
      t.string :url
      t.integer :main_menu_id

      t.timestamps
    end
  end
end
