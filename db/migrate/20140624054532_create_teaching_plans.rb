class CreateTeachingPlans < ActiveRecord::Migration
  def change
    create_table :teaching_plans do |t|

      t.timestamps
    end
  end
end
