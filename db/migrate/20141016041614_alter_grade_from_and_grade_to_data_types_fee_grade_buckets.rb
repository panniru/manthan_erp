class AlterGradeFromAndGradeToDataTypesFeeGradeBuckets < ActiveRecord::Migration
  def change
    change_column :fee_grade_buckets, :grade_from, "integer USING CAST(grade_from AS integer)"
    change_column :fee_grade_buckets, :grade_to, "integer USING CAST(grade_to AS integer)"
  end
end
