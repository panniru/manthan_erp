class CreateSalaryBreakUps < ActiveRecord::Migration
  def change
    create_table :salary_break_ups do |t|
      t.string :component
      t.string :component_code
      t.float :criteria
      t.string :break_up_type

      t.timestamps
    end
  end
end
