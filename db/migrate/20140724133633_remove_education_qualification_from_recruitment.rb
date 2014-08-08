class RemoveEducationQualificationFromRecruitment < ActiveRecord::Migration
  def change
    remove_column :recruitments, :education_qualification, :string
  end
end
