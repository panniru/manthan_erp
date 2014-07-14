class FeeReportsController < ApplicationController

  def payment_status_report
    respond_to do |format|
      format.json do
        render :json => FeeReports.payment_status_report_data(params[:grade_id])
      end
      
    end
  end

  def payment_type_details
    respond_to do |format|
      @transactions = FeeReports.payment_type_details_data(params[:grade_id], params[:payment_type_id])
      format.json do
        render :json => @transactions
      end
      format.pdf do
        @grade = GradeMaster.find(params[:grade_id])
        @payment_type = PaymentType.find(params[:payment_type_id])
        render :pdf => "Transactions",
        :formats => [:pdf, :haml],
        :page_size  => 'A4',
        :margin => {:top => '8mm',
          :bottom => '8mm',
          :left => '10mm',
          :right => '10mm'}
      end
    end
  end
  

  
end
