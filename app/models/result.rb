class Result < ActiveRecord::Base
  belongs_to :student_master
  belongs_to :grading_master
  belongs_to :grade_master


  def union
    "#{grade_master_id} - #{subject_master_id}"
  end

  def self.get_value(selected_user)
    
    grade = LabResult.all
    data = []
    data = grade.map do |x|
      {id: x.id, student_name: x.student_master.name, grade: x.student_master.grade_master.grade_name,grading: x.grading_master.grading_name , subject: x.listing.subject_master.subject_name, result_type: x.result_type, union: x.union}
    end
    return data
  end

end













def get_students
    respond_to do |format|
      format.json  do
        p params[:selected_user]
        a = params[:selected_user].split('-')[0].to_i
        b = params[:selected_user].split('-')[1].to_i
        # subjects = Issuing.select(:book_id,:student_master_id).group_by(&:student_master_id)
        final = []
        data =GradeBook.select(:no_of_books).where(:grade_master_id => a).first
        StudentMaster.where(:grade_master_id => a, :section_master_id => b).each do |student|
          issuings = []
          Issuing.belongs_to_student(student).each do |issuing|
            issuings << {issuing_id: issuing.id, book_id: issuing.book_id, book_name: issuing.book.name,book_issue: issuing.book_issue,book_return_date: issuing.book_return_date,book_issue_date: issuing.book_issue_date}
          end
          (data.no_of_books - issuings.count).times do |i|
            issuings << {issuing_id: nil,book_id: nil, book_name: nil, book_issue: nil,book_return_date: nil,book_issue_date: nil}
          end
          final << {student_id: student.id,student_name: student.name,grade_master_id: student.grade_master_id,section_master_id: student.section_master_id,issuing: issuings}
        end
        p "================"
        p final
        # return data
        render :json => final
      end
    end
  end

































