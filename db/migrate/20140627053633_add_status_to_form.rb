class AddStatusToForm < ActiveRecord::Migration
  def change
    add_column :forms, :status, :string
  end
end
