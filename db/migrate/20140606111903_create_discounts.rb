class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.float :discount_percent
      t.string :academic_year

      t.timestamps
    end
  end
end
