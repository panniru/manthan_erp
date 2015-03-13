class AddFieldsToFacultyMaster < ActiveRecord::Migration
  def change
    add_column :faculty_masters, :designation_master_id, :integer
    add_column :faculty_masters, :department_master_id, :integer
    add_column :faculty_masters, :ctc, :integer
    add_column :faculty_masters, :basic, :integer
    add_column :faculty_masters, :special_allowance, :integer
    add_column :faculty_masters, :date_of_joining, :date
    add_column :faculty_masters, :probation_date, :date
    add_column :faculty_masters, :confirmation_date, :date
    add_column :faculty_masters, :resignation_date, :date
    add_column :faculty_masters, :status, :string
    add_column :faculty_masters, :reason_for_resignation, :string
    add_column :faculty_masters, :p_f_no, :string
    add_column :faculty_masters, :bank_name, :string
    add_column :faculty_masters, :account_number, :string
    add_column :faculty_masters, :pan, :string
    add_column :faculty_masters, :father_or_husband_name, :string
    add_column :faculty_masters, :relation, :string
    add_column :faculty_masters, :code, :string
  end
end
