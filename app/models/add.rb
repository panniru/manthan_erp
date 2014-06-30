class Add < ActiveRecord::Base
  validates :title, :presence => true
 
  validates :description, :presence => true

  def self.search(search)
    return scoped unless search.present?
    where(['title LIKE ? OR date LIKE ? OR description LIKE ? ', "%#{search}%", "%#{search}%", "%#{search}%" ])
  end
end

