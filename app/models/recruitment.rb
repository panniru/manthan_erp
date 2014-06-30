class Recruitment < ActiveRecord::Base
  validates :title, :presence => true
  validates :education_details, :presence => true
  validates :experience, :presence => true

  def self.search(search)
    return scoped unless search.present?
    where(['title LIKE ? OR education_details LIKE ? OR experience LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%" ])
  end
end
