class FacultyMasterUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader
  HEADERS = ["code", "faculty_name", "designation_name", "department_name","father_or_husband_name", "relation", "gender", "dob", "email", "educational_qualification", "date_of_joining", "probation_date", "confirmation_date", "resignation_date", "reason_for_resignation", "p_f_no", "bank_name", "account_number", "pan", "ctc", "basic"]
  
  def persisted?
    false
  end

  def initialize(params = {})
    super(params[:file])
  end

  def save
    super do |row, params={}|
      row_hash = row.to_hash.slice(*headers_to_show)
      faculty_master = FacultyMaster.find_by_code(map_row_data(row_hash)["code"]) || FacultyMaster.new
      faculty_master.attributes = valid_attributes(map_row_data(row_hash))
      faculty_master.designation_master = faculty_master.designation_from_params
      faculty_master.department_master = faculty_master.department_from_params
      faculty_master.ctc = faculty_master.ctc.to_i
      faculty_master.basic = faculty_master.basic.to_i
      faculty_master.account_number = faculty_master.account_number.to_i.to_s
      faculty_master
    end
  end

  def headers_to_show
    HEADERS.map{|key| key_to_show(key)}
  end

  def map_row_data(row_hash)
    HEADERS.map{|key| [key, row_hash[key_to_show(key)]]}.to_h
  end

  def valid_attributes(row_hash)
    row_hash.select{|key, val| val.present?}
  end

  def key_to_show(key)
    if ["pan", "ctc"].include? key
      key.titleize.upcase 
    else
      key.titleize
    end
  end

  def xls_template(options = {})
    CSV.generate(options) do |csv|
      csv << headers_to_show
    end
  end

end
