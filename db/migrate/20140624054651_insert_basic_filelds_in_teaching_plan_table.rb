class InsertBasicFileldsInTeachingPlanTable < ActiveRecord::Migration
  def change
    change_table :teaching_plans do |t|
      t.string :grade_master_id
      t.string :section_master_id
      t.string  :plan
      t.date :teaching_date
      t.integer :user_id
      t.string :academic_year
    end	
  end
end
