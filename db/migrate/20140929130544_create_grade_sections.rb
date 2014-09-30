class CreateGradeSections < ActiveRecord::Migration
  def change
    create_table :grade_sections do |t|
      t.integer :section_master_id
      t.integer :grade_master_id

      t.timestamps
    end
  end
end
