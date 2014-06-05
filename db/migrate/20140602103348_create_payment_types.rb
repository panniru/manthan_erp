class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :code

      t.timestamps
    end
  end
end
