class ChangeFrom < ActiveRecord::Migration
  def up
    change_column :admissions, :from, :string
  end

  def down
    change_column :admissions, :from, :array
  end
end
