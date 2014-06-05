class CreateParentPaymentMasters < ActiveRecord::Migration
  def change
    create_table :parent_payment_masters do |t|
      t.integer :parent_id
      t.integer :student_id
      t.integer :payment_type_id
      t.date :next_payment_date

      t.timestamps
    end
  end
end
