class AddReturnToIssuing < ActiveRecord::Migration
  def change
    add_column :issuings, :return, :date
  end
end
