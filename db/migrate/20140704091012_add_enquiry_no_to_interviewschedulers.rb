class AddEnquiryNoToInterviewschedulers < ActiveRecord::Migration
  def change
    add_column :interviewschedulers, :enquiry_no, :string
  end
end
