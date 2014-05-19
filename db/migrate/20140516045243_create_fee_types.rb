class CreateFeeTypes < ActiveRecord::Migration
  def change
    create_table :fee_types do |t|
      t.string :fee_type

      t.timestamps
    end
  end
end
