class AddLocationIdToSpecialDayTransport < ActiveRecord::Migration
  def change
    add_column :special_day_transports, :location_id, :integer
  end
end
