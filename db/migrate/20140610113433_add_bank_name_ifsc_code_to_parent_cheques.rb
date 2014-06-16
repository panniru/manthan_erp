class AddBankNameIfscCodeToParentCheques < ActiveRecord::Migration
  def change
    add_column :parent_cheques, :bank_name, :string
    add_column :parent_cheques, :ifsc_code, :string
  end
end
