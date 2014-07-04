class AddStatusToDocumentuploaders < ActiveRecord::Migration
  def change
    add_column :documentuploaders, :status, :string
  end
end
