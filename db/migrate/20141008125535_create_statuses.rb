class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :reason

      t.timestamps
    end
  end
end
