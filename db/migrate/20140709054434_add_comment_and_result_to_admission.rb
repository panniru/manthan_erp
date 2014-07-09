class AddCommentAndResultToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :comment, :string
    add_column :admissions, :result, :string
  end
end
