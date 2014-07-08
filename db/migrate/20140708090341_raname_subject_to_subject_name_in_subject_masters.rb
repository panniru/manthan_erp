class RanameSubjectToSubjectNameInSubjectMasters < ActiveRecord::Migration
  def change
    change_table :subject_masters do |t|
    t.rename :subject, :subject_name
  end
  end
end
