class ContextDetector
  CONTEXT_CONTROLLER_MAPPER = {
    "fee_types" => "fee_management",
    "fee_grade_buckets" => "fee_management",
    "term_definitions" => "fee_management",
    "post_dated_cheques" => "fee_management",
    "grade_wise_fees" => "fee_management",
    "parent_payment_masters" => "fee_management",
    "parent_cheques" => "fee_management",
    "home" => "fee_management",
    "admissions" => "enquiry_admission",
    "time_tables" => "academic"
    
  }

  def self.get_context(key)
    CONTEXT_CONTROLLER_MAPPER[key].present? ? CONTEXT_CONTROLLER_MAPPER[key].classify.constantize.new : nil
  end
end
