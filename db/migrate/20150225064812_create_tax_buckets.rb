class CreateTaxBuckets < ActiveRecord::Migration
  def change
    create_table :tax_buckets do |t|
      t.integer :from
      t.integer :to
      t.integer :tax

      t.timestamps
    end
  end
end
