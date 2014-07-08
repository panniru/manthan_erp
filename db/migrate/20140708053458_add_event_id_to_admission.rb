class AddEventIdToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :event_id, :integer
  end
end
