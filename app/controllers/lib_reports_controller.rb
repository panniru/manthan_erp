class LibReportsController < ApplicationController
 
  def new
    @lib_report = LibReport.new
  end
  def index
   
    @issuings = Issuing.order('count_all DESC').group("book").count
  end

  def Leastused
    @issuings = Issuing.order('count_all ASC').group("book").count
  end
  def popup
    @student_masters = StudentMaster.all
    #StudentMaster.find_by grade_msater_id:'1'
    #@student_masters = StudentMaster.find_by grade_master_id: '1'
  end

end
1
