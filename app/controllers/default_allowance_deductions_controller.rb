class DefaultAllowanceDeductionsController < ApplicationController
  
  def index
    page = params[:page].present? ? params[:page] : 1
    @default_allowance_deductions = DefaultAllowanceDeduction.all.paginate(:page => page)
  end

  def new_upload
    @default_allowance_deduction_uploader = DefaultAllowanceDeductionUploader.new
    respond_to do |format|
      format.html { render "new_upload"}
      
    end
  end
  
  def upload
    @default_allowance_deduction_uploader = DefaultAllowanceDeductionUploader.new(params[:default_allowance_deduction_uploader])
    if @default_allowance_deduction_uploader.save
      flash[:success] = "Successfully uploaded"
      redirect_to default_allowance_deductions_path
    else
      flash[:error] = "Some problem occured while uploading.."
      render "new_upload"
    end
  end

  def delete_all
    DefaultAllowanceDeduction.destroy_all
    redirect_to default_allowance_deductions_path
  end
  
end
