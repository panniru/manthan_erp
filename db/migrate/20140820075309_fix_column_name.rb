class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :faculty_masters, :name, :faculty_name
    rename_column :staffrecruits, :name, :faculty_name
    
  end
end
