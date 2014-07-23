class StudentMaster < ActiveRecord::Base
  validates :name, :presence => true
  validates :dob, :presence => true
  validates :parent_id, :presence => true
  validates :grade_master_id, :presence => true
  validates :section_master_id, :presence => true
  validates :joining_date, :presence => true

  belongs_to :parent
  belongs_to :student_route_mapping
  belongs_to :grade_master
  belongs_to :section_master
  has_one :parent_payment_master, :foreign_key => :student_id
  has_many :issuings
  scope :ids_in_list, lambda{|ids| where("id in ?", ids)}
  def grade_bucket_id
    GradeBucketMapping.find_by_grade_master_id(self.grade_master).fee_grade_bucket_id
  end

  def fee_type_applicable?(fee_type)
    return self.bus_facility? if fee_type == "Bus Fee" 
    true
  end

end
