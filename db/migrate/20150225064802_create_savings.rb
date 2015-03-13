class CreateSavings < ActiveRecord::Migration
  def change
    create_table :savings do |t|
      t.integer :faculty_master_id
      t.integer :salary_tax_id
      t.string :saving_type
      t.integer :amount
      t.string :bill_no
      t.date :bill_date
      t.string :attachement
    end
  end
end
