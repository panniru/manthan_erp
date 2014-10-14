class CreateMainMenus < ActiveRecord::Migration
  def change
    create_table :main_menus do |t|
      t.string :main_menu_name
      t.string :icon_class
      t.string :url
    end
  end
end
