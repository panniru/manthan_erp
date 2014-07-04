class AddStatusToInterviewschedulers < ActiveRecord::Migration
  def change
    add_column :interviewschedulers, :status, :string
  end
end
