class StudentMaster < ActiveRecord::Base
  #validates :name, :presence => true
  #validates :dob, :presence => true
  #validates :parent_id, :presence => true
  #validates :grade_master_id, :presence => true
  #validates :section_master_id, :presence => true
  #validates :joining_date, :presence => true
  has_many :assessment_grade_mappings
  belongs_to :parent, :class_name => "ParentMaster" , :foreign_key => :parent_master_id
  belongs_to :student_route_mapping
  belongs_to :grade_master
  belongs_to :section_master
  belongs_to :location_master
  has_one :parent_payment_master, :foreign_key => :student_id
  has_many :issuings
  has_many :donation_of_books
  has_one :admission
  has_many :attendances, :dependent => :destroy
  has_one :student_route_mapping, :dependent => :destroy
  scope :ids_in_list, lambda{|ids| where("id in ?", ids)}
  scope :has_no_route , lambda{where("id not in (?)", StudentRouteMapping.all.map(&:student_master_id))}
  scope :belongs_to_grade_master, lambda{|grade_master| where("grade_master_id = ?",  grade_master)}
  scope :belongs_to_section_master, lambda{|section_master| where("section_master_id = ?",  section_master)}

  scope :has_bus_facility , lambda{where(:bus_facility => true)} 
  
  def grade_bucket_id
    GradeBucketMapping.find_by_grade_master_id(self.grade_master).fee_grade_bucket_id
  end

  def fee_type_applicable?(fee_type)
    return self.bus_facility? if fee_type == "Bus Fee" 
    true
  end

  def grade
    grade_master.present? ? grade_master.grade_name : nil
  end
  
  def section
    section_master.present? ? section_master.section_name : nil
  end
  def self.get_student_name(grade_master_id)
    student = StudentMaster.all
    name = []
    name = student.map do |x|
      {student_name: x.name, grade_master_id: x.grade_master_id}
    end
    return name
  end


end
