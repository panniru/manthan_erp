class AddFieldsToAdmission < ActiveRecord::Migration
  def change
    add_column :admissions, :sib_name2, :string
    add_column :admissions, :sib_age2, :string
    add_column :admissions, :sib_sex2, :string
    add_column :admissions, :sib_grade2, :string
    add_column :admissions, :sib_school2, :string
    add_column :admissions, :address_line1, :string
    add_column :admissions, :address_line2, :string
    add_column :admissions, :previous_city, :string
    add_column :admissions, :pin, :string
    add_column :parent_masters, :address_line1, :string
    add_column :parent_masters, :address_line2, :string
    add_column :parent_masters, :city, :string
    add_column :parent_masters, :pin, :string
    add_column :teacher_leaders, :faculty_master_id, :integer
    add_column :teacher_leaders, :grade_master_id, :integer
    add_column :teacher_leaders, :section_master_id, :integer
    add_column :admissions, :section_master_id, :integer
    


  end
end
