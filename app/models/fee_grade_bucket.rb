class FeeGradeBucket < ActiveRecord::Base
  has_many :grade_wise_fees, :dependent => :destroy
  
  def self.find_grade_bucket_by_grade(grade)
    #if is_number?(grade)
      FeeGradeBucket.where("? between to_number(grade_from, '99999') and to_number(grade_to, '99999')", grade).first
    # else
    #   FeeGradeBucket.where("grade_from = ? or grade_to = ? ", grade, grade).first
    # end
  end

  def bucket_name
    "#{self.grade_from} to #{self.grade_to}"
  end

  def self.is_number?(str)
    !!(str =~ /\A[-+]?[0-9]+\z/)
  end

end
