class CreateGradeBucketMappings < ActiveRecord::Migration
  def change
    create_table :grade_bucket_mappings do |t|
      t.integer :grade_master_id
      t.integer :fee_grade_bucket_id

      t.timestamps
    end
  end
end
