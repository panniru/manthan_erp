class TermFeeGrid
  
  def initialize(grades = []) 
    @term_fee_grid = nil
    @grade_list = grades
  end
  
  def get_grid
    @term_fee_grid ||= prepare_grid
  end

  def grid_headers
    terms = Set.new
    @applied_grade_fee ||= get_grid
    @applied_grade_fee.each do |term_fees|
      term_fees.each{|fee| terms.add(fee.term_definition_name)}
    end
    terms.to_a
  end

  def self.get_object_list_from_grid(params, academic_year)
    params.map do |param|
      param.select{|sel_unit|  sel_unit["amount_in_rupees"].present? }.map do |unit|
        if unit["id"].present?
          t_w_f = TermWiseGradeFee.find(unit["id"])
          t_w_f.amount_in_rupees =  unit["amount_in_rupees"] 
          t_w_f
        else
          TermWiseGradeFee.new(:id => unit["id"], :fee_grade_bucket_id => unit["fee_grade_bucket_id"], :term_definition_id => unit["term_definition_id"], :amount_in_rupees => unit["amount_in_rupees"], :academic_year => academic_year)
        end
      end
    end.flatten
  end

  private
 
  def get_grade_buckets_from_map
    FeeGradeBucket.where(:id =>GradeBucketMapping.belongs_to_grades(@grade_list).map{|gr_map| gr_map.fee_grade_bucket_id})
  end
  

  def prepare_grid
    amount_conversion = AmountConversion.new 
    get_grade_buckets_from_map.map do |bucket|
      total = bucket.grade_wise_fees.inject(0){|tot, fee| tot+fee.amount_in_rupees}
      TermDefinition.all.map do |term|
        term_wise_grd_fee = TermWiseGradeFee.belongs_to_fee_grade_bucket(bucket).belongs_to_term_difinition(term).first
        if term_wise_grd_fee.present?
          TermFeeUnit.new(:id => term_wise_grd_fee.id, :fee_grade_bucket_id => bucket.id, :fee_type_id => term.id, :fee_grade_bucket_name => bucket.bucket_name, :term_definition_name => term.term_definition, :amount_in_rupees => term_wise_grd_fee.amount_in_rupees)
        else
          TermFeeUnit.new(:fee_grade_bucket_id => bucket.id, :term_definition_id => term.id, :fee_grade_bucket_name => bucket.bucket_name, :term_definition_name => term.term_definition, :amount_in_rupees => amount_conversion.part_percentage_from_total_percentage(total, term.amount_per))
        end
      end
    end
  end
  
  class TermFeeUnit
    include Virtus.model
    attribute :id, String
    attribute :fee_grade_bucket_id, String
    attribute :term_definition_id, String
    attribute :amount_in_rupees, String
    attribute :fee_grade_bucket_name, String
    attribute :term_definition_name, String
  end

end
