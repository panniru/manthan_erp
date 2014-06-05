class GradeFeeGrid

  def initialize 
    @grade_fee_grid = nil
  end
  
  def get_grid
    @grade_fee_grid ||= prepare_grid
  end

  def grid_belongs_to_grades(grades)
    @applied_grade_fee =  []
    get_grid.each do |fee_grade|
      list = fee_grade.select{|bucket| grades.include? bucket.fee_grade_bucket_id.to_i }
      @applied_grade_fee << list unless list.empty?
    end
    @applied_grade_fee
  end

  def grid_belongs_to_grade(grade)
    @applied_grade_fee =  []
    get_grid.each do |fee_grade|
      list = fee_grade.select{|bucket| grade == bucket.fee_grade_bucket_id.to_i }
      @applied_grade_fee << list unless list.empty?
    end
    @applied_grade_fee
  end


  def grid_headers
    fee_types = Set.new
    @applied_grade_fee ||= get_grid
    @applied_grade_fee.each do |fee_grade|
      fee_grade.each{|fee| fee_types.add(fee.fee_type_name)}
    end
    fee_types.to_a
  end

  def grid_grade_buckets
    grades = Set.new
    @applied_grade_fee ||= get_grid
    @applied_grade_fee.each do |fee_grade|
      fee_grade.each{|fee| grades.add(fee.fee_grade_bucket_name)}
    end
    grades.to_a
  end

  def self.get_object_list_from_grid(params, acedemic_year)
    params.map do |param|
      param.select{|sel_unit|  sel_unit["amount_in_rupees"].present? }.map do |unit|
        if unit["id"].present?
          g_w_f = GradeWiseFee.find(unit["id"])
          g_w_f.amount_in_rupees =  unit["amount_in_rupees"] 
          g_w_f
        else
          GradeWiseFee.new(:id => unit["id"], :fee_grade_bucket_id => unit["fee_grade_bucket_id"], :fee_type_id => unit["fee_type_id"], :amount_in_rupees => unit["amount_in_rupees"], :acedemic_year => acedemic_year)
        end
      end
    end.flatten
  end


  private

  def prepare_grid
    FeeGradeBucket.all.map do |bucket|
      FeeType.all.map do |fee_type|
        grade_wise_fee = GradeWiseFee.find_by_fee_bucket_id_and_fee_type_id(bucket, fee_type).first
        if grade_wise_fee.present?
          GradeFeeUnit.new(:id => grade_wise_fee.id, :fee_grade_bucket_id => bucket.id, :fee_type_id => fee_type.id, :fee_grade_bucket_name => bucket.bucket_name, :fee_type_name => fee_type.fee_type, :amount_in_rupees => grade_wise_fee.amount_in_rupees)
        else
          GradeFeeUnit.new(:fee_grade_bucket_id => bucket.id, :fee_type_id => fee_type.id, :fee_grade_bucket_name => bucket.bucket_name, :fee_type_name => fee_type.fee_type)
        end
      end
    end
  end
  
  class GradeFeeUnit
    include Virtus.model
    attribute :id, String
    attribute :fee_grade_bucket_id, String
    attribute :fee_type_id, String
    attribute :amount_in_rupees, String
    attribute :fee_grade_bucket_name, String
    attribute :fee_type_name, String
  end

end
