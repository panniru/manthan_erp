class AddStaffIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :staff_id, :string
  end
end
