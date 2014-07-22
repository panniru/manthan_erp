class TeachingPlan < ActiveRecord::Base
  belongs_to :grade_master	
  belongs_to :section_master 
  belongs_to :subject_master
  
  attr_accessor :subject_master_name
  scope :belongs_to_student, lambda{|student| belongs_to_grade(student.grade_master_id).belongs_to_section(student.section_master_id)}
  scope :belongs_to_grade, lambda{|grade| where(:grade_master_id => grade)}
  scope :belongs_to_section, lambda{|section| where(:section_master_id => section)}
  scope :dated_on, lambda{|date| where(:teaching_date => date)}

  def self.student_teaching_plan(student, date)
    data = {}
    TeachingPlan.includes(:subject_master).select("teaching_plans.id", "teaching_plans.plan_month", "teaching_plans.teaching_date", "teaching_plans.subject_master_id", "subject_masters.subject_name").belongs_to_student(student).dated_on(date).order("teaching_plans.teaching_date DESC").group_by{|t| t.teaching_date}.each do |key, plans| 
      attrs = plans.map{|plan| plan.attributes.merge!(:subject_name => plan.subject_master.subject_name)}
      data[key.to_s] = attrs
    end
    data
  end  
  scope :belongs_to_faculty, lambda{|faculty| where(:faculty_master_id => faculty)} 

end
