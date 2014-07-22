class AddSubjectMasterIdToRecruitment < ActiveRecord::Migration
  def change
    add_column :recruitments, :subject_master_id, :integer
  end
end
