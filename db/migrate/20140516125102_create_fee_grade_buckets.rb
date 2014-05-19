class CreateFeeGradeBuckets < ActiveRecord::Migration
  def change
    create_table :fee_grade_buckets do |t|
      t.string :bucket_name

      t.timestamps
    end
  end
end
