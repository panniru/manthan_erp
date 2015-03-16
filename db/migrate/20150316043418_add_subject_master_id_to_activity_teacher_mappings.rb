class AddSubjectMasterIdToActivityTeacherMappings < ActiveRecord::Migration
  def change
  	add_column :activity_teachers_mappings, :subject_master_id, :integer

  	remove_column :activity_teachers_mappings, :activity_master_id, :integer
  end
end
