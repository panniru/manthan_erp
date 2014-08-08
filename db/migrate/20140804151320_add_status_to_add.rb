class AddStatusToAdd < ActiveRecord::Migration
  def change
    add_column :adds, :status, :string
  end
end
