class AddSubjectTypeToSubjetMasters < ActiveRecord::Migration
  def change
  	add_column :subject_masters, :subject_type, :string
  end
end
