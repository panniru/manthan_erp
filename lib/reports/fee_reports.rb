class FeeReports
  
  def self.payment_status_report_data(grade)
    ParentPaymentMaster.belongs_to_grade(grade).payment_type_wise_count_and_sum.map do |data|
      payment_type = PaymentType.find(data.payment_type_id)
      {payment_type_id: data.payment_type_id, payment_type: payment_type.code, count: data.count, total: data.sum}
    end
  end

  def self.payment_type_details_data(grade_id, payment_type_id)
    transactions = []
    ParentPaymentMaster.belongs_to_grade(grade_id).belongs_to_payment_type(payment_type_id).find_each do |payment_master|
      payment_master.parent_payment_transactions.each do |transaction|
        transactions << {student_name: payment_master.student.name, parent_name: payment_master.student.parent.parent_name, transaction_date: transaction.transaction_date, transaction_type: transaction.transaction_type, status: transaction.status, amount: transaction.amount_in_rupees}
      end
    end
    transactions
  end
  
end
