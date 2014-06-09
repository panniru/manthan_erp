class AddBucket1ToFeeGradeBuckets < ActiveRecord::Migration
  def change
    rename_column :fee_grade_buckets, :bucket_name, :grade_from
    add_column :fee_grade_buckets, :grade_to, :string
  end
end
