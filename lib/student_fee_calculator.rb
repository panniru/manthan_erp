class StudentFeeCalculator < Struct.new(:student)
  
  def applicable_total_fee
    @total ||= student_total 
  end
  
  def applicable_term_fee(term)
    final_amount(term.amount_in_rupees)
  end
  
  def applicable_month_fee(month)
    final_amount(month.amount_in_rupees)
  end
  

  def get_fee_type_contributions
    @contributions ||= contributions
  end

  private

  def contributions
    total = GradeWiseFee.total_grade_fee(student.grade_bucket_id)
    contributions = []
    GradeWiseFee.belongs_to_fee_grade_bucket(student.grade_bucket_id).each do |grade_fee|
      percentage = ((grade_fee.amount_in_rupees.to_f/total) * 100) 
      contributions << Struct.new(:fee_type_id, :fee_type, :contribution_percent).new(grade_fee.fee_type.id, grade_fee.fee_type.fee_type, percentage)
    end
    contributions
  end

  def student_total
    total = 0
    GradeWiseFee.belongs_to_fee_grade_bucket(student.grade_bucket_id).each do |grade_fee|
      if student.fee_type_applicable?(grade_fee.fee_type.fee_type) 
        total = total + grade_fee.amount_in_rupees
      end
    end
    total
  end

  def final_amount(amount_in_rupees)
    amount = amount_in_rupees
    get_fee_type_contributions.each do |fee_type|
      unless student.fee_type_applicable?(fee_type.fee_type)
        amount = amount - ((fee_type.contribution_percent/100) * amount_in_rupees)
      end
    end
    amount
  end

end
