class DefaultAllowanceDeduction < ActiveRecord::Base
  belongs_to :faculty_master

  def self.valid_attributes
    @@keys ||= self.new.attributes.keys
    @@keys.delete("id")
    @@keys.delete("faculty_master_id")
    @@keys.delete("created_at")
    @@keys.delete("updated_at")
    @@keys
  end
  
  scope :belongs_to_employee, lambda{|faculty_master| where(:faculty_master_id => faculty_master)}
end
