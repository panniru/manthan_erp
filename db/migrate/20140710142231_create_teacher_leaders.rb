class CreateTeacherLeaders < ActiveRecord::Migration
  def change
    create_table :teacher_leaders do |t|
      t.string :admission_id
      t.string :klass
      t.string :faculty_leader

      t.timestamps
    end
  end
end
