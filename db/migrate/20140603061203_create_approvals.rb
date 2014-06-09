class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.string :approved
      t.string :def_by
      t.string :status
      t.string :year

      t.timestamps
    end
  end
end
