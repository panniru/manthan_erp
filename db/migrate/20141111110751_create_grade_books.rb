class CreateGradeBooks < ActiveRecord::Migration
  def change
    create_table :grade_books do |t|
      t.integer :grade_master_id
      t.integer :no_of_books

      t.timestamps
    end
  end
end
