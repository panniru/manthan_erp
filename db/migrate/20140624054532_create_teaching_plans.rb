class CreateTeachingPlans < ActiveRecord::Migration
  def change
    create_table :teaching_plans do |t|
      t.string :plan_month  
      t.integer :user_id
      t.string :academic_year
      t.string :grade_master_id
      t.string :section_master_id
      t.string  :plan
      t.date :teaching_date
      t.timestamps
    end
  end
end
