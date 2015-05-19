class RemoveFieldToIssuings < ActiveRecord::Migration
  def change
    remove_column :issuings, :deleted_at, :datetime
 
  end
end

