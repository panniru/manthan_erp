class PaymentReceipt < ActiveRecord::Base
  belongs_to :parent_payment_transaction
  before_save :generate_receipt_code
  attr_accessor :branch_abbr, :receipt_date
  
  scope :receipts_on_date, lambda{|date| where("to_char(created_at, 'YYYY-mm-dd') = ? ",date.strftime("%Y-%m-%d"))}
  
  def generate_receipt_code
    count = PaymentReceipt.receipts_on_date(receipt_date).count
    mm_yy = receipt_date.strftime('%m%y')
    five_digit_float = '%.5f' % ((count+1).to_f/100000)
    self.code = branch_abbr+mm_yy+five_digit_float.to_s.split(".")[1]
  end
  
end
