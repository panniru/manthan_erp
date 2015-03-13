class FacultyLeaveUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  include Uploader
  SHEET1_HEADERS = ["code"  , "days_worked" , "working_days" , "lop" , "sl" , "pl" , "cl"]
  
  attr_accessor :month
  attr_accessor :year

  def persisted?
    false
  end
  
  def initialize(params = {})
    super(params[:file])
    @month = params[:month]
    @year = params[:year]
    #@entered_date = params[:entered_date]
  end

  def save
    super do |row, params={}|
      faculty_leave = FacultyLeave.new
      row_hash = row.to_hash.slice(*headers_to_show_sheet1)
      faculty_leave.attributes = map_row_data_of_sheet1(row_hash)
      faculty_master = FacultyMaster.find_by(:code => faculty_leave.attributes['code'])
      faculty_leave.faculty_master_id = faculty_master.id
      faculty_leave.month = @month
      faculty_leave.year = @year
      faculty_leave.entered_date = Date.new(@year.to_i, Date::MONTHNAMES.index(@month), 1)
      faculty_leave
    end
  end
  
  def headers_to_show_sheet1
    SHEET1_HEADERS.map(&:titleize)
  end
  def headers_to_show_sheet2
    SHEET2_HEADERS.map(&:titleize)
  end
   
   def map_row_data_of_sheet1(row_hash)
     SHEET1_HEADERS.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
   
   def map_row_data_of_sheet2(row_hash)
     SHEET2_HEADERS.map{|key| [key, row_hash[key.titleize]]}.to_h
   end
   
 end
 
