class BookIssuingFormObject
  include Virtus.model
  attribute :student, StudentMaster
  attribute :issuings, []

  def self.create_collection(params = [])
    issuing_objs = []
    params.each do |param|
      param[:issuings].each do |issuing|
        if issuing[:id].present?
          issuing_obj = Issuing.find(issuing[:id])
          issuing_obj.book = issuing[:book]
          # if issuing[:is_issued].present? and (issuing[:is_issued] == "true" or issuing[:is_issued]
          #                                      issuing_obj.issuing_date = DateTime.now
          #                                    end
          if issuing[:is_returned].present? and ( issuing[:is_returned] == "true" or issuing[:is_returned]) 
            issuing_obj.returned_date = DateTime.now
          end 
        else
          issuing_obj = Issuing.new({student_master_id: param[:student_master_id], book: issuing[:book]})
        end
        issuing_objs << issuing_obj
      end
    end
    if issuing_objs.all?
      status = issuing_objs.map(&:save!)
      status.map.all?
    else
      return false
    end
  end
  
  def self.build(student)
    form_object = BookIssuingFormObject.new
    form_object.student = student
    if student.issuings.empty?
      form_object.book_count(student.grade_master_id).times.each do |t|
        form_object.issuings << Issuing.new
      
      end
    else
      form_object.issuings = student.issuings
      (form_object.book_count(student.grade_master_id) - form_object.issuings.count).times.each do |t|
        form_object.issuings << Issuing.new
        
      end
    end
    return form_object
  end

  def book_count(grade)
    3
  end
  
  def self.build_collection(students)
    students.map do |student|
      BookIssuingFormObject.build(student)
    end
  end

end
