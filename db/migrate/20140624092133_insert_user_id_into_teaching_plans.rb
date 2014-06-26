class InsertUserIdIntoTeachingPlans < ActiveRecord::Migration
  def change
    change_table :teaching_plans do |t|
   	  t.string :plan_month  
      t.integer :user_id
      t.string :academic_year
    end	
  end
end
