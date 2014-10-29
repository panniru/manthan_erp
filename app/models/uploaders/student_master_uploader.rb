class StudentMasterUploader
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include Uploader

  def persisted?
    false
  end

  def initialize(params = {})
    super(params[:file])
  end

  def save
    super do |row|
      student = StudentMaster.new
      student.attributes = row.to_hash.slice("name", "dob", "joining_date")
      student.bus_facility = row.to_hash["bus_facility"] == 'N' ? false : true
      #student.academic_year = row.to_hash["academic_year"].to_i.to_s
      student.parent_master_id = row.to_hash["parent_id"].to_i.to_s
      student.grade_master = GradeMaster.find_by_grade_name(row.to_hash["grade"].kind_of?(String) ? row.to_hash["grade"] : row.to_hash["grade"].to_i.to_s)
      student.section_master = SectionMaster.find_by_section_name(row.to_hash["section"].to_s)
      student
    end
  end

  def xls_template(options)
    template_headers = ["name", "dob", "joining_date", "parent_id", "grade", "section", "academic_year", "bus_facility"]
    CSV.generate(options) do |csv|
      csv << template_headers
    end
  end

end
