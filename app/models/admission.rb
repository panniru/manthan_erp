class Admission < ActiveRecord::Base


  def self.search(search)
    return scoped unless search.present?
    where(['admission_no LIKE ? OR form_no LIKE ? OR name LIKE ? OR klass LIKE ?  OR father_name LIKE ? OR father_mobile LIKE ?  ', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
  end
end
