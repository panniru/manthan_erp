class RenameSectionToSectionMasterIdInStudentMasters < ActiveRecord::Migration
  def change
    rename_column :student_masters, :section, :section_master_id
  end
end
