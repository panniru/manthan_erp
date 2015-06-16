class AddFieldsToStaffrecruits < ActiveRecord::Migration
  def change
    add_column   :staffrecruits, :ctc	, :integer	
    add_column   :staffrecruits, :basic	, :integer	
    add_column   :staffrecruits, :special_allowance	, :integer	
    add_column   :staffrecruits, :date_of_joining	, :date
    add_column   :staffrecruits, :probation_date	, :date
    add_column   :staffrecruits, :confirmation_date	, :date
    add_column   :staffrecruits, :p_f_no	, :string	
    add_column   :staffrecruits, :bank_name	, :string
    add_column   :staffrecruits, :account_number	, :string
    add_column   :staffrecruits, :pan	, :string
    add_column   :staffrecruits, :father_or_husband_name	, :string
    add_column   :staffrecruits, :relation	, :string

  end
end
